//////////////////////////////////////////////////////////////////////////////////////////////
//qinfra.q - contains functions for Q infrastructure
///
//

// set the params
//@param x: key value pair dictionary for all the parameters
.qr.setParams:{
    .qr.priv.param:.Q.def[x].Q.opt .z.x;
    };

// construct a parameter
//@param x: key
//@param y: default value
.qr.param:{
    (enlist x) ! enlist y
    };

// retrive parameter
//@param x: key
//
.qr.getParam:{
    .qr.priv.param x
    };

// list the params
.qr.listParam:{
    .qr.priv.param
    };

//initialize loading utility
.qr.init:{
    if[()~key `.qr.priv.module;
        .qr.priv.module:([] module:`$(); script:(); time:"p"$());
        ];

    if[()~key `.qr.priv.param;
        .qr.setParams ()!();
        ];
    };

// load module
//@param m: module name
//
.qr.load:{[m]
    .qr.include[m;"module.q"];
    };

// include the script
//@param m: module name
//@[aram s: script
//
.qr.include:{[m;s]
    m:$[-11h=type m; m; `$m];
    s:$[-11h=type s; s; `$s];
    s:$[null m; string s; .qr.getParam[m], "/", string s];
    .qr.priv.include[m;s];
    };

// list all the modules loaded
.qr.listModule:{
    .qr.priv.module
    };

// reload existing mudoles
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

.qr.init[];