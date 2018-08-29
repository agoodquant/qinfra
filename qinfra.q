//////////////////////////////////////////////////////////////////////////////////////////////
//qinfra.q - contains functions for Q infrastructure
///
//

.qinfra.loadDep:{[m;p]
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

.qinfra.cleanDep:{
    delete from `.qr.priv.depend;
    };

.qinfra.listDep:{
    .qr.priv.depend
    };

.qinfra.addDep:{[m;p]
    `.qr.priv.dependStack upsert (m;p);
    };

.qinfra.getDep:{
    exec first path from .qr.priv.depend where module = x
    };

.qinfra.load:{[m]
    .qinfra.include[m;"module.q"];
    };

.qinfra.include:{[m;s]
    m:$[-11h=type m; m; `$m];
    s:$[-11h=type s; s; `$s];
    s:$[null m; string s; .qinfra.getDep[m], "/", string s];
    .qinfra.priv.include[m;s];
    };

.qinfra.listModule:{
    .qr.priv.module
    };

.qinfra.reload:{
    exec .qinfra.priv.include'[module;script] from .qr.priv.module;
    };

.qinfra.priv.include:{[m;s]
    value "\\l ", s;

    $[0 = exec count i from .qr.priv.module where module=m, script like s;
        `.qr.priv.module insert (m;s;.z.p);
        update time:.z.p from `.qr.priv.module where module=m, script like s
        ];
    };

.qinfra.init:{
    if[()~key `.qr.priv.module;
        .qr.priv.module:([] module:`$(); script:(); time:"p"$());
        ];

    if[()~key `..qr.priv.depend;
        .qr.priv.depend:([module:`$()] path:());
        .qr.priv.dependStack:([] module:`$(); path:());
        ];

    if[`depend in key .Q.opt .z.x;
        .qinfra.loadDep[`;ssr[(raze/) .Q.opt[.z.x]`depend;"\\";"/"]];
        ];

    if[`init in key .Q.opt .z.x;
        .qinfra.include[`;ssr[(raze/) .Q.opt[.z.x]`init;"\\";"/"]];
        ];
    };

.qinfra.init[];