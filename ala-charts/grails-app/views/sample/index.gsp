<%@ page import="org.codehaus.groovy.grails.commons.ConfigurationHolder" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chart sampler</title>
    <link rel="stylesheet" href="${resource(dir:'css',file:'charts.css')}" />
    <script type="text/javascript" language="javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" language="javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript" src="http://jquery-jsonp.googlecode.com/files/jquery.jsonp-2.1.4.min.js"></script>
    <style>
    input[type=radio] {margin-left: 15px;}
    h1 {color: #718804 }
    </style>
    <g:external uri="http://github.com/cowboy/jquery-bbq/raw/master/jquery.ba-bbq.min.js"/>
    <r:require module="charts"/>
    <r:layoutResources/>
</head>
<body style="padding: 20px;">
<h1>Chart sampler</h1>
<h2>Enter a query and choose a chart type</h2>
<label for="query">Query:</label> <input id="query" type="text" size="80" value="Macropus"/>
<button type="button" id="draw">Draw chart</button>
<div style="margin: 20px 0;">
    <div style="padding-right: 10px; float:left; height:120px;">Type:</div>
    <div id="types" style="display:inline; max-width:600px;">
        <div style="padding-bottom:10px;">
            <g:radio name="type" value="taxonomy"/> Taxonomy
            (optional: - <label for="rank">starting rank:</label> <input id="rank" type="text" size="20"/> OR
            <label for="max">threshold:</label> <input id="max" type="text" size="20"/>)
        </div>
        <div style="padding-bottom: 8px;">
            <g:radio name="type" value="state"/> State
            <g:radio name="type" value="institution_uid" checked="checked"/> Institution
            <g:radio name="type" value="data_resource_uid"/> Data set
            <g:radio name="type" value="type_status"/> Types
            <g:radio name="type" value="species_group"/> Common groups
        </div>
        <div style="padding-bottom: 8px;">
            <g:radio name="type" value="assertions"/> Data assertions
            <g:radio name="type" value="decade"/> Decades
            <g:radio name="type" value="biogeographic_region"/> Biogeographic region
            <g:radio name="type" value="state_conservation"/> State conservation
        </div>
        <div style="padding-bottom: 8px;">
            <g:radio name="type" value="other"/> Other named facet:
            <label for="other"></label> <input id="other" type="text" size="40"/>
        </div>
        <div style="padding-bottom: 8px;">
            <g:radio name="type" value="el"/> Environmental layer:
            <label for="el"></label> <input id="el" type="text" size="40" value="radiation"/>
        </div>
    </div>
</div>

<div id="charts"></div>

<r:script type="text/javascript">
    var biocacheServicesUrl = "http://biocache.ala.org.au/ws";
    var biocacheWebappUrl = "http://biocache.ala.org.au/";
    var taxonomyChartOptions = { rank: "kingdom", error: "badQuery" }
    var facetChartOptions = { error: "badQuery" }
    $('#draw').click(drawChart);
    $('body').keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            drawChart();
        }
    });

    function drawChart() {
        var facetName;
        $('#charts').html("");
        var query = $('#query').val();
        var type = $('#types input:checked').val();
        $.bbq.pushState({'query':query});
        $.bbq.pushState({'type':type});
        if (type == "taxonomy") {
            taxonomyChartOptions.query = query;
            taxonomyChartOptions.rank = $('#rank').val();
            if (taxonomyChartOptions.rank == "") {
                taxonomyChartOptions.threshold = $('#max').val();
            } else {
                taxonomyChartOptions.threshold = "";
            }
            taxonomyChart.load(taxonomyChartOptions);
        }
        else if (type == "other") {
            facetChartOptions.query = query;
            facetName = $('#other').val();
            if (facetName == "") {
                alert("You must enter the name of the facet you wish to chart.");
                return;
            }
            facetChartOptions.charts = [facetName];
            facetChartGroup.loadAndDrawFacetCharts(facetChartOptions);
        }
        else if (type == "el") {
            facetName = $('#el').val();
            if (facetName == "") {
                alert("You must enter the name of the environmental layer you wish to chart.");
                return;
            }
            facetChartOptions.query = query;
            facetChartOptions.charts = [facetName];
            facetChartOptions[facetName] = {chartType: 'scatter'};
            facetChartGroup.loadAndDrawFacetCharts(facetChartOptions);
        }
        else {
            facetChartOptions.query = query;
            facetChartOptions.charts = [type];
            facetChartGroup.loadAndDrawFacetCharts(facetChartOptions);
        }
    }

    function badQuery() {
        $('#charts').append($('<span>Bad query</span>'));
    }
    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(function() {
        var query = $.bbq.getState('query'),
            type = $.bbq.getState('type');
        if (query !== undefined) {
            $('#query').val(query);
        }
        if (type !== undefined) {
            var it = $('input[value=' + type + ']').attr('checked',true);
        }
        if (query || type) {
            drawChart();
        }
    });
</r:script>
<r:layoutResources/>
</body>
</html>