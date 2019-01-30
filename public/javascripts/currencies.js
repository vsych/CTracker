if($("#currencies_chart_div").size() > 0) {
    var update_chart = function(data){
        $('.simple_pie_chart').each(function() {
            chart = SimplePieChart.initialize(this);
            chart.sets = {
                "Collected": data["Collected"],
                "Not Collected": data["Not Collected"]
            };
            chart.render();
        });
    };

    var draw_chart = function(url, el){
        var chart = chart;
        var url = url;
        var el = el;
        $.ajax({
            url: url,
            dataType: "json",
            success: function(data, status, jq){
                var labels = [["Date", "Count"]];
                d = data.collection.map(function(el){
                    return [el.date, el.cnt];
                });
                var chart = new window.Chart(el, {title: "Statistic of Currencies Collection"});
                chart.draw(labels.concat(d));
            },
            error: function(jq, status, error){
                alert(status);
            }
        });
    };

    draw_chart("/currencies/statistic.json", $("#currencies_chart_div")[0]);
    $("table#collection").bind("chart.update", function(){
        draw_chart("/currencies/statistic.json", $("#currencies_chart_div")[0]);
    });
}
