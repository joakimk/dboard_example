(function() {
  jQuery.extend (String.prototype, {
  camelize: function () {
    return this.replace (/(?:^|[-_])(\w)/g, function (_, c) {
      return c ? c.toUpperCase () : '';
    })
  }
});;
  var Dashboard;
  Dashboard = (function() {
    function Dashboard() {
      this.widgets = {};
      this.types = [];
      this.loaded = false;
      this.checksums = {};
    }
    Dashboard.prototype.addWidget = function(name, klass) {
      this.widgets[name] = new klass;
      return this.types.push(name);
    };
    Dashboard.prototype.run = function() {
      this.update();
      return setInterval(this.update, 1000);
    };
    Dashboard.prototype.update = function() {
      return $.ajax({
        url: "/sources?types=" + (window.dashboard.types.join(',')),
        dataType: "json",
        timeout: 10000,
        success: function(data) {
          if (data["version"] !== window.dashboard_version) {
            window.location.reload();
            return;
          }
          for(var key in data["sources"]) {
         var checksum = data["sources"][key].checksum;
         if(window.dashboard.checksums[key] != checksum) {
           if(console && console.log)
             console.log("New data for " + key + ", updating.")
           window.dashboard.widgets[key].render(data["sources"][key].data);
           window.dashboard.checksums[key] = checksum;
         }
       };
          if (!window.dashboard.loaded) {
            window.dashboard.loaded = true;
            return console.log("Loaded");
          }
        }
      });
    };
    return Dashboard;
  })();
  window.Dashboard = Dashboard;
}).call(this);
