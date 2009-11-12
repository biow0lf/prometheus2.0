TableKit.Sortable.addSortType(
  new TableKit.Sortable.Type('repocop', {
    pattern : /^[skip|ok|info|experimental|warn|fail]$/,
    normal : function(v) {
      switch(v) {
        case 'skip':
          return 0;
          break;
        case 'ok':
          return 1;
          break;
        case 'info':
          return 2;
          break;
        case 'experimental':
          return 3;
          break;
        case 'warn':
          return 4;
          break;
        case 'fail':
          return 5;
          break;
        default:
          return 6;
      }
    }
  }
));

