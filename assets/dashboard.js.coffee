`jQuery.extend (String.prototype, {
  camelize: function () {
    return this.replace (/(?:^|[-_])(\w)/g, function (_, c) {
      return c ? c.toUpperCase () : '';
    })
  }
});`

class Dashboard
  constructor: ->
    @widgets = {}
    @types = []
    @loaded = false
    @checksums = {}

  addWidget: (name, klass) ->
    @widgets[name] = new klass
    @types.push name
   
  run: ->
    this.update()
    setInterval this.update, 1000

  update: ->
    $.ajax url: "/sources?types=#{window.dashboard.types.join(',')}", dataType: "json", timeout: 10000, success: (data) ->
       if data["version"] != window.dashboard_version
         window.location.reload()
         return

       `for(var key in data["sources"]) {
         var checksum = data["sources"][key].checksum;
         if(window.dashboard.checksums[key] != checksum) {
           if(console && console.log)
             console.log("New data for " + key + ", updating.")
           window.dashboard.widgets[key].render(data["sources"][key].data);
           window.dashboard.checksums[key] = checksum;
         }
       }`

       if !window.dashboard.loaded
         window.dashboard.loaded = true
         console.log("Loaded")
       #  # $("#loading_notice").hide()
       #  # $("#sections").show()



window.Dashboard = Dashboard
