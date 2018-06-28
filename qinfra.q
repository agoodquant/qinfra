//////////////////////////////////////////////////////////////////////////////////////////////
//qinfra.q - contains functions for Q infrastructure
///
//

.qr.loadDep:{[m;p]
    if[exec count i from .qr.priv.dependStack where module=m, path like p;
        delete from `.qr.priv.dependStack;
        '`$"cyclying dependency";
        ];

    `.qr.priv.depend upsert (m;p);
    `.qr.priv.dependStack insert (m;p); // enqueue
    dependTxt:`$p, "/", "depends.txt";
    if[not () ~ key hsym dependTxt;
        dep:("SS"; " ") 0:dependTxt;
        .z.s'[first dep;string last dep]; // recursive stack
        ];
    delete from `.qr.priv.dependStack where module = m, path like p; // dequeue
    };

.qr.cleanDep:{
    delete from `.qr.priv.depend;
    };

.qr.listDep:{
    .qr.priv.depend
    };

.qr.addDep:{[m;p]
    `.qr.priv.dependStack upsert (m;p);
    };

.qr.getDep:{
    exec first path from .qr.priv.depend where module = x
    };

.qr.load:{[m]
    .qr.include[m;"module.q"];
    };

.qr.include:{[m;s]
    m:$[-11h=type m; m; `$m];
    s:$[-11h=type s; s; `$s];
    s:$[null m; string s; .qr.getDep[m], "/", string s];
    .qr.priv.include[m;s];
    };

.qr.listModule:{
    .qr.priv.module
    };

.qr.reload:{
    exec .qr.priv.include'[module;script] from .qr.priv.module;
    };

.qr.priv.include:{[m;s]
    value "\\l ", s;

    $[0 = exec count i from .qr.priv.module where module=m, script like s;
        `.qr.priv.module insert (m;s;.z.p);
        update time:.z.p from `.qr.priv.module where module=m, script like s
        ];
    };

.qr.init:{
    if[()~key `.qr.priv.module;
        .qr.priv.module:([] module:`$(); script:(); time:"p"$());
        ];

    if[()~key `..qr.priv.depend;
        .qr.priv.depend:([module:`$()] path:());
        .qr.priv.dependStack:([] module:`$(); path:());
        ];
    };

.qr.init[];