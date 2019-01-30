var update_collection = function(table, collection, complete_callback){
    if(collection.length == 0) return;
    var checkbox = $(collection.shift());
    $.ajax({
        url: $(checkbox).data("url")
        , dataType: "json"
        , beforeSend: function(jq, settings){
            checkbox.attr("disabled", true);
        }
        , success: function(data, status, jq){
            tr = table.find("tr#record_"+checkbox.data("code"));
            tr.find("td.status").html(data.status);
            checkbox.data("dirty", "false");
        }
        , error: function(jq, status, error){
            alert(error);
        }
        , complete: function(jq, status){
            checkbox.attr("disabled", false);
            var data = jQuery.parseJSON(jq.responseText);
            if(typeof complete_callback === 'function'){
                complete_callback.call(table, data);
            }
            update_collection(table, collection, complete_callback);
            table.trigger("chart.update");
        }
    });
};

var table = $("table#collection");
table.find("input[type='checkbox']").on("change", function(e){
    var checkbox = $(e.currentTarget);
    update_collection(table, [checkbox], update_chart);
});


var check_controll = $("#select-all-controll");
var apply_controll = $("#apply-filter-controll");
var filter = $("#name-filter");
var filter_updated_callback = function(e){
    var target = $(e.currentTarget);
    if(target.val().length >= 1) {
        // reset check all button to initial state
        check_controll.attr("disabled", false);
        check_controll.data("action", "check");
        check_controll.val("Check All");
        apply_controll.attr("disabled", false);
        table.find("tbody tr").each(function(ind, elem){
            var el = $(elem);
            var pattern = new RegExp("^"+target.val(), "i");
            if(pattern.test($(elem).find("td.name").html())){
                el.removeClass("hidden");
            } else {
                el.addClass("hidden");
            }
        });
    } else if(target.val().length == 0) {
        check_controll.attr("disabled", true);
        apply_controll.attr("disabled", true);
        table.find("tbody tr").removeClass("hidden");
    }
};
filter.on("change", filter_updated_callback);
filter.on("keyup", filter_updated_callback);

check_controll.on("click", function(e){
    e.preventDefault();
    var checkboxes = [];
    var el = $(e.currentTarget);
    action = el.data("action");
    if(action === "check") {
        el.val("Uncheck All");
        el.data("action", "uncheck")
        chk = true
        checkboxes = table.find("tbody tr:visible input[type='checkbox']:not(:checked)")
    } else {
        el.val("Check All");
        el.data("action", "check")
        chk = false;
        checkboxes = table.find("tbody tr:visible input[type='checkbox']:checked")
    }

    checkboxes.attr("checked", chk);
    checkboxes.data("dirty", "true");
});

apply_controll.on("click", function(e){
    e.preventDefault();
    var checkboxes = table.find("tbody tr:visible input[type='checkbox']:checked").filter(function(ind){
        return $(this).data("dirty") === "true";
    });
    update_collection(table, $.makeArray(checkboxes), update_chart);
});
