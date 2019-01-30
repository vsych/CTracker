;(function(){
    google.load("visualization", "1", {packages:["corechart"]});
    window.Chart = function(element, opts){
        that = this;
        this.element = element;
        this.options = {
            title: 'Statistic',
            hAxis: {title: 'Progress', titleTextStyle: {color: 'red'}}
        };
        if(typeof opts == "object"){
            for(var prop in opts){
                if(opts.hasOwnProperty(prop)){
                    that.options[prop] = opts[prop]
                }
            }
        }
        return {
            draw: function(raw_data){
                var data = google.visualization.arrayToDataTable(raw_data);
                var chart = new google.visualization.ColumnChart(that.element);
                chart.draw(data, that.options);
                return true;
            }
        };
    };
})();
