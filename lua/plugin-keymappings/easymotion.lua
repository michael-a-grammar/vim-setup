return function(opts)
  if opts.use.easymotion then
    local map = require'milque.cartographer'.with.nx

    map()
      .use(',F')
      .rhs
        .plug('easymotion-bd-f')
      .exe()

    map()
      .use(',SF')
      .rhs
        .plug('easymotion-overwin-f2')
      .exe()

    map()
      .use(',Sf')
      .rhs
        .plug('easymotion-overwin-f')
      .exe()

    map()
      .use(',Sl')
      .rhs
        .plug('easymotion-overwin-line')
      .exe()

    map()
      .use(',Sw')
      .rhs
        .plug('easymotion-overwin-w')
      .exe()

    map()
      .use(',T')
      .rhs
        .plug('easymotion-bd-t')
      .exe()

    map()
      .use(',f')
      .rhs
        .plug('easymotion-bd-fl')
      .exe()

    map()
      .use(',ke')
      .rhs
        .plug('easymotion-iskeyword-bd-e')
      .exe()

    map()
      .use(',kw')
      .rhs
        .plug('easymotion-iskeyword-bd-w')
      .exe()

    map()
      .use(',s/')
      .rhs
        .plug('easymotion-sn')
      .exe()

    map()
      .use(',s<up>')
      .rhs
        .plug('easymotion-k')
      .exe()

    map()
      .use(',s<right>')
      .rhs
        .plug('easymotion-linebackward')
      .exe()

    map()
      .use(',s<down>')
      .rhs
        .plug('easymotion-j')
      .exe()

    map()
      .use(',s<left>')
      .rhs
        .plug('easymotion-lineforward')
      .exe()

    map()
      .use(',sA')
      .rhs
        .plug('easymotion-jumptoanywhere')
      .exe()

    map()
      .use(',sE')
      .rhs
        .plug('easymotion-bd-e')
      .exe()

    map()
      .use(',sN')
      .rhs
        .plug('easymotion-prev')
      .exe()

    map()
      .use(',sS')
      .rhs
        .plug('easymotion-s')
      .exe()

    map()
      .use(',sW')
      .rhs
        .plug('easymotion-bd-w')
      .exe()

    map()
      .use(',sa')
      .rhs
        .plug('easymotion-lineanywhere')
      .exe()

    map()
      .use(',se')
      .rhs
        .plug('easymotion-bd-el')
      .exe()

    map()
      .use(',sf')
      .rhs
        .plug('easymotion-bd-f2')
      .exe()

    map()
      .use(',sn')
      .rhs
        .plug('easymotion-next')
      .exe()

    map()
      .use(',ss')
      .rhs
        .plug('easymotion-s2')
      .exe()

    map()
      .use(',st')
      .rhs
        .plug('easymotion-bd-t2')
      .exe()

    map()
      .use(',sw')
      .rhs
        .plug('easymotion-bd-wl')
      .exe()

    map()
      .use(',t')
      .rhs
        .plug('easymotion-bd-tl')
      .exe()
  end
end
