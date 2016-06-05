/* Generated by Opal 0.9.2 */
(function(Opal) {
  Opal.dynamic_require_severity = "error";
  var OPAL_CONFIG = { method_missing: true, arity_check: false, freezing: true, tainting: true };
  function $rb_divide(lhs, rhs) {
    return (typeof(lhs) === 'number' && typeof(rhs) === 'number') ? lhs / rhs : lhs['$/'](rhs);
  }
  function $rb_ge(lhs, rhs) {
    return (typeof(lhs) === 'number' && typeof(rhs) === 'number') ? lhs >= rhs : lhs['$>='](rhs);
  }
  function $rb_plus(lhs, rhs) {
    return (typeof(lhs) === 'number' && typeof(rhs) === 'number') ? lhs + rhs : lhs['$+'](rhs);
  }
  var self = Opal.top, $scope = Opal, nil = Opal.nil, $breaker = Opal.breaker, $slice = Opal.slice, $klass = Opal.klass, grid = nil;

  Opal.add_stubs(['$attr_reader', '$canvas_id', '$canvas', '$floor', '$/', '$height', '$width', '$>=', '$context', '$+', '$new', '$draw_canvas']);
  (function($base, $super) {
    function $Grid(){};
    var self = $Grid = $klass($base, $super, 'Grid', $Grid);

    var def = self.$$proto, $scope = self.$$scope;

    self.$attr_reader("height", "width", "canvas", "context", "max_x", "max_y");

    Opal.cdecl($scope, 'CELL_HEIGHT', 15);

    Opal.cdecl($scope, 'CELL_WIDTH', 15);

    Opal.defn(self, '$initialize', function() {
      var self = this;

      self.height = $(window).height();
      self.width = $(window).width();
      self.canvas = document.getElementById(self.$canvas_id());
      self.context = self.$canvas().getContext('2d');
      self.max_x = ($rb_divide(self.$height(), $scope.get('CELL_HEIGHT'))).$floor();
      return self.max_y = ($rb_divide(self.$width(), $scope.get('CELL_WIDTH'))).$floor();
    });

    Opal.defn(self, '$draw_canvas', function() {
      var $a, $b, self = this, x = nil, y = nil;

      self.$canvas().width  = self.$width();
      self.$canvas().height = self.$height();
      x = 0.5;
      while (!((($b = $rb_ge(x, self.$width())) !== nil && (!$b.$$is_boolean || $b == true)))) {
      self.$context().moveTo(x, 0);
      self.$context().lineTo(x, self.$height());
      x = $rb_plus(x, $scope.get('CELL_WIDTH'));};
      y = 0.5;
      while (!((($b = $rb_ge(y, self.$height())) !== nil && (!$b.$$is_boolean || $b == true)))) {
      self.$context().moveTo(0, y);
      self.$context().lineTo(self.$width(), y);
      y = $rb_plus(y, $scope.get('CELL_HEIGHT'));};
      self.$context().strokeStyle = "#eee";
      return self.$context().stroke();
    });

    return (Opal.defn(self, '$canvas_id', function() {
      var self = this;

      return "conwayCanvas";
    }), nil) && 'canvas_id';
  })($scope.base, null);
  grid = $scope.get('Grid').$new();
  return grid.$draw_canvas();
})(Opal);
