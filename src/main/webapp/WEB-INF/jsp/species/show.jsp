<%@ page contentType="text/html" pageEncoding="UTF-8" %><%@
include file="/common/taglibs.jsp" %><%@ taglib uri="/tld/taglibs-string.tld" prefix="string" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="alatag" %>
<c:set var="spatialPortalUrl">http://spatial.ala.org.au/</c:set>
<c:set var="spatialPortalWMSUrl">http://spatial.ala.org.au/alaspatial/</c:set>
<c:set var="wordPressUrl">${initParam.centralServer}</c:set>
<c:set var="biocacheUrl">${initParam.biocacheUrl}</c:set>
<c:set var="biocacheWSUrl">http://biocache.ala.org.au/ws/</c:set>
<c:set var="citizenSciUrl">http://cs.ala.org.au/bdrs-ala/bdrs/user/atlas.htm?surveyId=1&guid=</c:set>
<c:set var="collectoryUrl">http://collections.ala.org.au</c:set>
<c:set var="threatenedSpeciesCodes">${wordPressUrl}/about/program-of-projects/sds/threatened-species-codes/</c:set>
<!DOCTYPE html>
<html dir="ltr" lang="en-US">
	<% long start = System.currentTimeMillis(); %>
    <head>
    	<c:set var="pageName">${extendedTaxonConcept.taxonConcept.nameString} <c:if test="${not empty extendedTaxonConcept.commonNames}"> : ${extendedTaxonConcept.commonNames[0].nameString}</c:if></c:set>	
        <meta name="pageName" content="Taxon profile page for ${pageName}" />
        <meta name="description" content="This is the aggregated view of information and content from the Atlas of Living Australia for the taxon ${extendedTaxonConcept.taxonConcept.nameString}"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>${extendedTaxonConcept.taxonConcept.nameString} <c:if test="${not empty extendedTaxonConcept.commonNames}"> : ${extendedTaxonConcept.commonNames[0].nameString}</c:if> | Atlas of Living Australia</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/js/jquery-fancybox/jquery.fancybox-1.3.4.css" media="screen" />
        <link type="text/css" media="screen" rel="stylesheet" href="${pageContext.request.contextPath}/static/css/colorbox.css" />
        <script language="JavaScript" type="text/javascript" src="${wordPressUrl}/wp-content/themes/ala/scripts/ui.core.js"></script>
        <script language="JavaScript" type="text/javascript" src="${wordPressUrl}/wp-content/themes/ala/scripts/ui.tabs.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-fancybox/jquery.fancybox-1.3.4.pack.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.colorbox-min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.easing.1.3.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.favoriteIcon.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.qtip-1.0.0.min.js"></script>
        <script type="text/javascript" src="http://www.google.com/jsapi"></script>
        <script type="text/javascript">
 
        // load the spital map

            /*
             * OnLoad equivilent in JQuery
             */
            $(document).ready(function() {
                
            	if(${extendedTaxonConcept.taxonConcept.rankID} >= 7000){
            		var isAussieTxt = "${extendedTaxonConcept.isAustralian}";
            		var isAussie = false;
	            	var isAustralianUrl = "../species/isAustralian.json?guid=${extendedTaxonConcept.taxonConcept.guid}&isAussie=${extendedTaxonConcept.isAustralian}"; 
	                $.getJSON(isAustralianUrl, function(data) {
	                	if(isAussieTxt != null && isAussieTxt != ""){
	                		isAussie = (isAussieTxt === 'true');
	                	}
	                	if(data!=null && data.isAustralian != isAussie){
	                		if(data.isAustralian){                	
	                			$("#iucn_div").html('<span id="iucn_span" class="iucn native">&nbsp;</span>Recorded In Australia');
	                		}
	                		else{
	                			$("#iucn_div").html('<span id="iucn_span" class="iucn nonnative">&nbsp;</span>Not Recorded In Australia');
	                		}
	                	}
	                });
            	}
            	
            	
            	/*
            	// replaced by biocache ws call in image tag...
            	// eg: <img id="mapImage" src='http://biocache.ala.org.au/ws/density/map?q=lsid:"${extendedTaxonConcept.taxonConcept.guid}"' class="distroImg" width="360" alt="occurrence map" onerror="this.style.display='none'"/>
            	var spitalUrl = "../map/map.json?guid=${extendedTaxonConcept.taxonConcept.guid}"; 
                $.getJSON(spitalUrl, function(data) {
                     //alert(data.type)
                     if(data!=null && data.mapUrl != null && data.mapUrl.length > 0 && data.type != "blank"){
                        $("#mapImage").attr("src",data.mapUrl);
                        //$("#mapImage").attr("hidden",false);
                        if(data.legendUrl != null && data.legendUrl.length > 0
                             && data.type != null && data.type == 'heatmap'){
                            $("#mapLegend").attr("src",data.legendUrl);
                            $("#mapLegend").css("display","block");
                            $("#legendDiv").css("display","block");
                        } else {
                            $("#legendDiv").css("display","none");
                        }
                        $("#divMap").css("display","block");
                     } else {
                         $("#divMap").css("display","none");
                     }
                });
 				*/
 				
                // LSID link to show popup with LSID info and links
                $("a#lsid").fancybox({
                    'hideOnContentClick' : false,
                    'titleShow' : false,
                    'autoDimensions' : false,
                    'width' : 600,
                    'height' : 180
                });
                
                $("a.contributeLink").fancybox({
                    'hideOnContentClick' : false,
                    'titleShow' : false,
                    'autoDimensions' : false,
                    'width' : 680,
                    'height' : 220
                });

                // Dena's tabs implementation
                $('#nav-tabs > ul').tabs();
                //$('#nav-tabs > ul').bind("tabsshow", function(event, ui) {
                //    window.location.hash = ui.tab.hash;
                //})
                // Display full image when thumbnails are clicked
                function formatTitle(title, currentArray, currentIndex, currentOpts) {
                    return '<div id="tip7-title"><span></span>' +
                        (title && title.length ? '<b>' + title + '</b>' : '' ) + '<br/>Image ' + (currentIndex + 1) + ' of ' + currentArray.length + '</div>';
                }

                // Gallery image popups using ColorBox
                $("a.thumbImage").colorbox({
                    title: function() {
                        var titleBits = this.title.split("|");
                        return "<a href='"+titleBits[1]+"'>"+titleBits[0]+"</a>"; },
                    opacity: 0.5,
                    maxWidth: "80%",
                    maxHeight: "80%",
                    preloading: false,
                    onComplete: function() {
                        $("#cboxTitle").html(""); // Clear default title div
                        var index = $(this).attr('id').replace("thumb",""); // get the imdex of this image
                        var titleHtml = $("div#thumbDiv"+index).html(); // use index to load meta data
                        $("<div id='titleText'>"+titleHtml+"</div>").insertAfter("#cboxPhoto");
                        $("div#titleText").css("padding-top","8px");
                        $.fn.colorbox.resize();
                    }
                });

                // images in overview tab should trigger lightbox
                $("#images ul a").click(function(e) {
                    e.preventDefault(); //Cancel the link behavior
                    //$('#nav-tabs > ul').tabs( "select" , 1 );
                    var thumbId = "thumb" + $(this).attr('href');
                    $("a#"+thumbId).click();  // simulate clicking the lightbox links in Gallery tab
                });

                // Check for valid distribution map img URLs (Hacked for IE)
                $('img.distroImg').each(function(i, n) {
                    // if img doesn't load, then hide its surround div
                    $(this).error(function() {
                        //alert("img error");
                        $(this).parent().parent().hide();
                    });
                    // IE hack as IE doesn't trigger the error handler
                    if ($.browser.msie && !n.complete) {
                        //alert("IE img error");
                        $(this).parent().parent().hide();
                    }
                });

                $('img.distroLegend').each(function(i, n) {
                    // if img doesn't load, then hide its surround div
                    $(this).error(function() {
                        //alert("img error");
                        $(this).parent().hide();
                    });
                    // IE hack as IE doesn't trigger the error handler
                    if ($.browser.msie && !n.complete) {
                        //alert("IE img error");
                        $(this).parent().hide();
                    }
                });
                // overviewImage
                $('img.overviewImage').each(function(i, n) {
                    // if img doesn't load, then check for alternate img src
                    $(this).error(function() {
                        var src = $(this).attr('src').replace('/smallRaw.', '/raw.');
                        //alert("img error: "+src);
                        $(this).attr('src', src);
                    });
                    // IE hack as IE doesn't trigger the error handler
                    if ($.browser.msie && !n.complete) {
                        var src = $(this).attr('src').replace('/smallRaw.', '/raw.');
                        //alert("img error: "+src);
                        $(this).attr('src', src);
                    }
                });
                
                // mapping for facet names to display labels
                var facetLabels = {
                    state: "State &amp; Territory",
                    data_resource: "Dataset",
                    month: "Date (by month)", 
                    occurrence_year: "Date (by decade)"
                };
                var months = {
                    "01": "January",
                    "02": "February",
                    "03": "March",
                    "04": "April",
                    "05": "May",
                    "06": "June",
                    "07": "July",
                    "08": "August",
                    "09": "September",
                    "10": "October",
                    "11": "November",
                    "12": "December"
                };
                
                // load the collections that contain specimens
                //var colSpecUrl = "${pageContext.request.contextPath}/species/source/${extendedTaxonConcept.taxonConcept.guid}"; 
                var colSpecUrl = "${biocacheWSUrl}occurrences/taxon/source/${extendedTaxonConcept.taxonConcept.guid}.json?fq=basis_of_record:PreservedSpecimen&callback=?"; 
                $.getJSON(colSpecUrl, function(data) {
                    if (data != null &&data != null && data.length >0){
                        var content = '<h4>Collections that hold specimens: </h4>';
                        content = content +'<ul>';
                        $.each(data, function(i, li) {
                            if(li.uid.match("^co")=="co"){
                                var link1 = '<a href="${collectoryUrl}/public/show/' + li.uid +'">' + li.name + '</a>';
                                var link2 = '(<a href="${biocacheUrl}/occurrences/taxa/${extendedTaxonConcept.taxonConcept.guid}?fq=collection_uid:'
                                link2 = link2 + li.uid +'&fq=basis_of_record:PreservedSpecimen">' + li.count + ' records</a>)';
                                content = content+'<li>' + link1 + ' ' + link2+'</li>';

                            }
                        });
                        content = content + '</ul>';
                        $('#recordBreakdowns').append(content);
                    }
                });

                // load occurrence breakdowns for states
                //var biocachUrl = "${pageContext.request.contextPath}/species/charts/${extendedTaxonConcept.taxonConcept.guid}";
                var biocachUrl = "${biocacheWSUrl}occurrences/taxon/${extendedTaxonConcept.taxonConcept.guid}.json?callback=?";
                //var biocachUrl = "${biocacheWSUrl}occurrences/search.json?q=lsid:${extendedTaxonConcept.taxonConcept.guid}&facets=state&facets=month&facets=data_resource&facets=year&callback=?";
                $.getJSON(biocachUrl, function(data) {
                	
                    if (data.totalRecords != null && data.totalRecords > 0) {
                        //alert("hi "+data.totalRecords);
                        var count = data.totalRecords + ""; // concat of emtyp string forces var to a String
                        $('#occurenceCount').html(count.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")); // update link text at top with count (formatted)
                        //console.log('facets: ', data.facetResults);
                        var facets = data.facetResults;
                        $.each(facets, function(index, facet) {
                            //console.log(node.fieldName, node.fieldResult);
                            //if (node.fieldName == 'state' || node.fieldName == 'state' ||node.fieldName == 'state') {
                            if (facet.fieldName in facetLabels) {
                                // dataTable for chart
                                var data = new google.visualization.DataTable();
                                var chart;
                                data.addColumn('string', facetLabels[facet.fieldName]);
                                data.addColumn('number', 'Records');
                                // HTML content 
                                var isoDateSuffix = '-01-01T12:00:00Z';
                                var content = '<h4>By '+ facetLabels[facet.fieldName] +'</h4>';
                                content = content +'<ul>';
                                // intermediate arrays to store facet values in - needed to handle the
                                // irregular date facet "before 1850" which comes at end of facet list
                                var rows = [];
                                var listItems = [];
                                var totalCount = 0;
                                $.each(facet.fieldResult, function(i, li) {
                                    if (li.count > 0) {
                                        totalCount += li.count; // keep a tally of total counts
                                        var label = li.label;
                                        var toValue;
                                        var displayCount = (li.count + "").replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
                                        var link = '<a href="${biocacheUrl}occurrences/taxa/${extendedTaxonConcept.taxonConcept.guid}?fq='
                                        
                                        if (facet.fieldName == 'occurrence_year') {
                                            if (label == 'before') { // label.indexOf(searchValue, fromIndex)
                                                label = label + ' 1850';
                                                toValue = '1850' + isoDateSuffix;
                                                link = link + facet.fieldName+':[* TO '+toValue+']">';
                                            } else {
                                                label = label.replace(isoDateSuffix, '');
                                                toValue = parseInt(label) + 10;
                                                label = label + '-' + toValue;
                                                toValue = toValue + isoDateSuffix;
                                                link = link + facet.fieldName+':['+li.label+' TO '+toValue+']">';
                                            }
                                        } else if (facet.fieldName == 'month') {
                                            link = link + facet.fieldName+':'+li.label+'">';
                                            label = months[label]; // substitiute month name for int value
                                        } else {
                                            link = link + facet.fieldName+':'+li.label+'">';
                                        }
                                        //content = content +'<li>'+label+': ' + link + displayCount + ' records</a></li>';
                                        // add values to chart
                                        //data.addRow([label, li.count]);
                                        if (label == 'before 1850') {
                                            // add to start of array 
                                            rows.unshift([label, li.count]);
                                            listItems.unshift('<li>'+label+': ' + link + displayCount + ' records</a></li>');
                                        } else {
                                            // add to end of array
                                            rows.push([label, li.count]);
                                            listItems.push('<li>'+label+': ' + link + displayCount + ' records</a></li>');
                                        }
                                    }
                                });

                                // some date facets are all empty and this causes a JS error message, so recordCount checks for this
                                if (totalCount > 0) {
                                    $.each(rows, function(i, row) {
                                        // add to Google data table
                                        data.addRow([ row[0], row[1] ]);
                                    });
                                    $.each(listItems, function(i, li) {
                                        // build content string
                                        content = content + li;
                                    });
                                    content = content + '</ul><div id="'+facet.fieldName+'_chart_div" style="margin: -10px;"></div>';
                                    $('#recordBreakdowns').append(content);

                                    if (facet.fieldName == 'occurrence_date' || facet.fieldName == 'month') {
                                        var dateLabel = (facet.fieldName == 'occurrence_date') ? 'Decade' : 'Month';
                                        chart = new google.visualization.BarChart(document.getElementById(facet.fieldName+'_chart_div'));
                                        chart.draw(data, {width: 630, height: 300, legend: 'none', vAxis: {title: dateLabel}, hAxis: {title: 'Count'}});
                                    } else {
                                        chart = new google.visualization.PieChart(document.getElementById(facet.fieldName+'_chart_div'));
                                        chart.draw(data, {width: 630, height: 300, legend: 'left'});
                                    }
                                }
                            }
                        });
                    } else {
                        // hide the occurrence record section if no data or biocache is offline
                        $('#occurrenceRecords').html("No records found");
                    }
                });

                // Adds an icon (favicon taken from URL) for a given link
                $("#onlineResources a.infosource").favoriteIcon({
                    iconClass : 'favoriteIcon',
                    insertMethod: 'insertBefore',
                    missingImgUrl: '${pageContext.request.contextPath}/static/images/blank.gif'
                });

                // change body id for Dena's custom CSS
                $("body").attr("id","taxon");

                //Switch the "Open" and "Close" state per click then slide up/down (depending on open/close state)
                $('p.trigger').click(function(){
                    $(this).toggleClass('active').prev().toggleClass('full');
                    //$(this).toggleClass('active').next().toggleClass('full').slideToggle('slow');
                });

                var statusIconsCount = $('div.toggle div#status div').length;
                //alert("Number of status icons: "+statusIconsCount);
                if (statusIconsCount == 0) {
                    $('div.status').hide();
                } else if (statusIconsCount > 4) {
                    $('div.status').css('height','14em');
                } else if (statusIconsCount > 8) {
                    $('div.status').css('height','24em');
                } else if (statusIconsCount > 12) {
                    $('p.trigger').show();
                }

                // Add the class 'last' to every 4th status div
                $('div.toggle div#status div').each(function(i, el) {
                    if ((i+1) % 4 == 0) {
                        //console.log("4th div? ", i);
                        $(this).addClass("last");
                    }
                });

                // truncate text to 250 chars
                var limit = 250;
                $('span.truncateZZ').each(function(i, el) {
                    var length = $(this).html().length;
                    //console.log("truncate length " + i, length);
                    if (length > limit) {
                        var html = $(this).html().substring(0,limit);
                        $(this).html(html).append('...');
                    }
                });
                
                // help popup for classification icon: recorded in australia
                $('#recordedIn img, #recordedIn span').qtip({ style: { name: 'light', tip: true } });
                var isAustralian = "${extendedTaxonConcept.isAustralian}";
                var showTaxaHtml = 'Only listing child taxa recorded in Australia. <a href="#" id="showAllChildren">Show all child taxa</a>.';
                var hideTaxaHtml = 'Listing all child taxa. <a href="#" id="showAustChildren">Show only child taxa recorded in Australia</a>.';
                var numberOfInferredPlacement = $('span.inferredPlacement').length;
                
                if (isAustralian == 'true' && numberOfInferredPlacement > 0) {
                    $('ul.childClassification li').hide();
                    $('ul.childClassification li.recorded').show();
                    $('#isAustralianSwitch').html(showTaxaHtml);
                    
                    //var offset = $('ul.childClassification').position();
                    //console.log("offset", offset);
                    var top = "138px"; // (offset.top - 45) + "px";
                    var left = "405px"; // (offset.left + 300) + "px";
                    
                    
                    $('#isAustralianSwitch').css({
                        'position': 'absolute',
                        'width': '440px',
                        'left': left,
                        'top': top,
                        'padding': '3px 4px 2px 6px',
                        'background-color': '#D9D9D9'
                    });
                }
                
                $('#showAllChildren').live("click", function(e) {
                    e.preventDefault();
                    $('#isAustralianSwitch').html(hideTaxaHtml);
                    $('ul.childClassification li').show();
                });
                
                $('#showAustChildren').live("click", function(e) {
                    e.preventDefault();
                    $('#isAustralianSwitch').html(showTaxaHtml);
                    $('ul.childClassification li').hide();
                    $('ul.childClassification li.recorded').show();
                });
                
            });  // end document ready function

            /**
             * Escape special characters for SOLR query
             */
            function filterQuery(data) {
                data = data.replace(/\:/g, "\\:");
                data = data.replace(/\-/g, "\\-");
                return data;
            }

            google.load("visualization", "1", {packages:["corechart"]});

        </script>
        <link rel="stylesheet" type="text/css" href="${wordPressUrl}/wp-content/themes/ala/css/speciesPage.css" media="screen" />
        <style type="text/css">
            /* Temp styles to be added to speciesPage.css in WP ALA theme */
            div.rankCommonName {
                position: relative;
                width: 170px;
                font-size: 11px;
                line-height: 1.3em;
                background-color: #FFF;
                padding: 5px;
                margin-left: 10px;
                border: 1px solid gray;
                -webkit-border-radius: 0 8px 8px 8px;
                -moz-border-radius: 0 8px 8px 8px;
                border-radius: 0 8px 8px 8px;
                -webkit-box-shadow: 4px 4px 4px #ccc;
                -moz-box-shadow: 4px 4px 4px #ccc;
                box-shadow: 4px 4px 4px #ccc;
            }
             #names table div.rankCommonName a {
                 background: none;
                 padding: 0;
            }
        </style>
    </head>
    <body id="taxon">
        <div id="header" class="taxon">
	        <c:set var="sciNameFormatted"><alatag:formatSciName name="${scientificName}" rankId="${extendedTaxonConcept.taxonConcept.rankID}"/></c:set>
            <c:set var="authorship">${authorship}</c:set>
            <c:set var="contributeURL" value="${biocacheUrl}share/sighting/${extendedTaxonConcept.taxonConcept.guid}"/>
            <div id="breadcrumb">
                <ul>
                    <li><a href="${wordPressUrl}">Home</a></li>
                    <li><a href="${wordPressUrl}/explore">Explore</a></li>
                    <li>${sciNameFormatted} ${authorship} <c:if test="${not empty extendedTaxonConcept.commonNames}"> : ${extendedTaxonConcept.commonNames[0].nameString}</c:if></li>
                </ul>
            </div>
            <div class="section full-width">
                <div class="container2"> 
                    <div class="container1"> 
                        <div class="hrgroup"> 
                            <h1>${sciNameFormatted} <span>${authorship}</span></h1>
                            <h2><c:if test="${not empty extendedTaxonConcept.commonNames}">${extendedTaxonConcept.commonNames[0].nameString}</c:if></h2> 
                        </div> 
                        <div class="meta"> 
                            <h3>Rank</h3><p style="text-transform: capitalize;">${extendedTaxonConcept.taxonConcept.rankString}</p>
                            <c:if test="${not empty extendedTaxonConcept.taxonConcept.infoSourceName && not empty extendedTaxonConcept.taxonConcept.infoSourceURL}">
                            <h3>Name source</h3><p><a href="${extendedTaxonConcept.taxonConcept.infoSourceURL}" target="_blank" class="external">${extendedTaxonConcept.taxonConcept.infoSourceName}</a></p>
                            </c:if>
                            <h3>Data links</h3><p><a href="#lsidText" id="lsid" class="local" title="Life Science Identifier (pop-up)">LSID</a>
                                | <a href="${pageContext.request.contextPath}/species/${extendedTaxonConcept.taxonConcept.guid}.json" class="local" title="JSON web service">JSON</a>
                                <!-- | <a href="${pageContext.request.contextPath}/species/${extendedTaxonConcept.taxonConcept.guid}.xml" class="local" title="XML web service">XML</a> -->
                            </p>
                            <div style="display:none; text-align: left;">
                                <div id="lsidText" style="text-align: left;">
                                    <b><a href="http://lsids.sourceforge.net/" target="_blank">Life Science Identifier (LSID):</a></b>
                                    <p style="margin: 10px 0;"><a href="http://lsid.tdwg.org/summary/${extendedTaxonConcept.taxonConcept.guid}" target="_blank">${extendedTaxonConcept.taxonConcept.guid}</a></p>
                                    <p style="font-size: 12px;">LSIDs are persistent, location-independent,resource identifiers for uniquely naming biologically
                                        significant resources including species names, concepts, occurrences, genes or proteins,
                                        or data objects that encode information about them. To put it simply,
                                        LSIDs are a way to identify and locate pieces of biological information on the web. </p>
                                </div>
                            </div>
                        </div> 
                    </div> 
                </div>
            </div>
            <div id="taxacrumb">
                <ul>
                    <c:forEach items="${taxonHierarchy}" var="taxon">
                        <c:if test="${taxon.rankId % 1000 == 0}"><%-- Only display major ranks. NdR --%>
                            <li>
                                <c:if test="${taxon.guid != extendedTaxonConcept.taxonConcept.guid}">
                                    <a href="<c:url value='/species/${taxon.guid}'/>" title="${taxon.rank}">
                                </c:if>
                                <c:if test="${taxon.rankId>=6000}"><i></c:if>${taxon.name}<c:if test="${taxon.rankId>=6000}"></i></c:if>
                                <c:if test="${taxon.guid != extendedTaxonConcept.taxonConcept.guid}"></a>
                                </c:if>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
            <div id="nav-tabs">
                <ul>
                    <li><a href="#overview">Overview</a></li>
                    <c:if test="${not empty extendedTaxonConcept.screenshotImages || not empty extendedTaxonConcept.images}"><li><a href="#gallery">Gallery</a></li></c:if>
                    <%--<li><a href="#identification">Identification</a></li>--%>
                    <li><a href="#names">Names</a></li>
                    <li><a href="#classification">Classification</a></li>
                    <li><a href="#records">Records</a></li>
                    <%--<li><a href="#biology">Biology</a></li>
                    <li><a href="#molecular">Molecular</a></li>--%>
                    <c:if test="${not empty extendedTaxonConcept.references}"><li><a href="#literature">Literature</a></li></c:if>
                </ul>
            </div>
        </div><!--close section_page-->
        <div id="overview">
            <div id="column-one">
                <div class="section">
                    <c:if test="${not empty descriptionBlock || (not empty spatialPortalMap && !fn:containsIgnoreCase(spatialPortalMap.mapUrl, 'mapaus1_white'))}">
                        <h2 style="text-transform: capitalize;">${extendedTaxonConcept.taxonConcept.rankString} overview</h2>
                    </c:if>
                    <div  id="divMap" class="distroMap section no-margin">
                        <h3>Mapped occurrence records</h3>
                        <p>
                            <a href="${biocacheUrl}occurrences/taxa/${extendedTaxonConcept.taxonConcept.guid}">View occurrence records list</a>
                            | <a href="${spatialPortalUrl}?q=lsid:${extendedTaxonConcept.taxonConcept.guid}" title="View interactive map">View interactive map</a>
                        </p>
                        <div class="left">
                            <img id="mapImage" src='http://biocache.ala.org.au/ws/density/map?q=lsid:"${extendedTaxonConcept.taxonConcept.guid}"' class="distroImg" width="360" alt="occurrence map" onerror="this.style.display='none'"/>
                        </div>
                        <div id="legendDiv" class="left" style="margin-top: 80px; margin-left: 20px;">
                            <img id="mapLegend" src='http://biocache.ala.org.au/ws/density/legend?q=lsid:"${extendedTaxonConcept.taxonConcept.guid}"' class="distroLegend" alt="map legend" onerror="this.style.display='none'"/>
                        </div>
                        <p style="clear: both; margin-left: 50px;"><span class="asterisk-container"><a href="${wordPressUrl}/about/progress/map-ranges/">Learn more about Atlas maps</a>&nbsp;</span></p>
                    </div>
                    <c:set var="descriptionBlock">
                        <c:forEach var="textProperty" items="${textProperties}" varStatus="status">
                            <c:if test="${fn:endsWith(textProperty.name, 'hasDescriptiveText') && status.count < 3 && textProperty.infoSourceId!=1051}">
                                <p>${textProperty.value} <cite>source: <a href="${textProperty.identifier}" target="_blank" title="${textProperty.title}">${textProperty.infoSourceName}</a></cite></p>
                            </c:if>
                        </c:forEach>
                    </c:set>
                    <c:if test="${not empty descriptionBlock}">
                        <h3>Description</h3>
                        ${descriptionBlock}
                    </c:if>
                    <c:if test="${not empty extendedTaxonConcept.identificationKeys}">
                        <h3>Identification Keys</h3>
                        <ul>
                            <c:forEach var="idKey" items="${extendedTaxonConcept.identificationKeys}">
                                <li>
                                    <a href="${idKey.url}" target="_blank">${idKey.title}</a>
                                    <c:if test="${not empty idKey.infoSourceURL}">(source: ${idKey.infoSourceName})</c:if>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>
                    <h2>Online Resources</h2>
                    <table cellpadding="0" cellspacing="0" id="onlineResources">
                        <colgroup style="width:50%;"></colgroup> 
                        <colgroup></colgroup> 
                        <tbody> 
                            <c:forEach var="entry" items="${infoSources}" varStatus="status">
                                <c:set var="infoSource" value="${entry.value}"/>
                                <c:if test="${infoSource.infoSourceId!=1051 && infoSource.infoSourceId!=1061 && infoSource.infoSourceId!=1073}">
                                <tr class="border-top">
                                    <td style="white-space: nowrap;">
                                        <c:choose>
                                        	<c:when test="${not empty infoSource.infoSourceURL && infoSource.infoSourceURL == 'http://www.ala.org.au'}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${infoSource.infoSourceName}</c:when>
                                            <c:when test="${not empty infoSource.identifier}"><a href="${infoSource.identifier}" target="_blank" class="infosource">${infoSource.infoSourceName}</a></c:when>
                                            <c:when test="${not empty infoSource.infoSourceURL}"><a href="${infoSource.infoSourceURL}" target="_blank" class="infosource">${infoSource.infoSourceName}</a></c:when>
                                            <c:otherwise>${infoSource.infoSourceName}</c:otherwise>
                                        </c:choose><!--${status.count}-->
                                    </td>
                                    <td class="small-font">
                                        <c:forEach items="${infoSource.sections}" var="section" varStatus="s">
                                            <fmt:message key="${section}"/><c:if test="${!s.last}">,</c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                                <c:if test="${fn:length(infoSource.text) > 100}">
                                    <tr>
                                        <td colspan="2"><p><span class="truncate">${infoSource.text}</span>
                                        <c:if test="${not empty infoSource.identifier && fn:length(infoSource.text) > 100}"><a href="${infoSource.identifier}" target="_blank">more</a></p></td></c:if>
                                    </tr>
                                </c:if>
                                </c:if>
                                <c:if test="${infoSource.infoSourceId==1073}">
                                <tr class="border-top">
                                    <td style="white-space: nowrap;">
                                        <c:choose>
                                            <c:when test="${not empty infoSource.infoSourceURL}"><a href="${infoSource.infoSourceURL}" target="_blank" class="infosource">${infoSource.infoSourceName}</a></c:when>
                                            <c:otherwise>${infoSource.infoSourceName}</c:otherwise>
                                        </c:choose><!--${status.count}-->
                                    </td>
                                    <td class="small-font">
                                        <c:forEach items="${infoSource.sections}" var="section" varStatus="s">
                                            <fmt:message key="${section}"/><c:if test="${!s.last}">,</c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                                <c:if test="${fn:length(infoSource.text) > 100}">
                                    <tr>
                                        <td colspan="2"><p><span class="truncate">${infoSource.text}</span>
                                        <c:if test="${not empty infoSource.identifier && fn:length(infoSource.text) > 100}"><a href="${infoSource.identifier}" target="_blank">more</a></p></td></c:if>
                                    </tr>
                                </c:if>
                                </c:if>
                                
                            </c:forEach>
                        </tbody> 
                    </table> 
                    
                    <c:if test="${false && empty textProperties && empty extendedTaxonConcept.images}">
                        <div class="sorry sighting no-margin-top">
                            <div>
                                <h3><a href="#contributeOverlay" class="contributeLink">Can you help us?
                                    <span><b>Share</b> sightings, photos and data for 
                                        <c:choose>
                                            <c:when test="${not empty extendedTaxonConcept.commonNames}">the <strong>${extendedTaxonConcept.commonNames[0].nameString}</strong></c:when>
                                            <c:otherwise><c:if test="${extendedTaxonConcept.taxonConcept.rankID <= 6000}">the ${extendedTaxonConcept.taxonConcept.rankString} </c:if><strong>${sciNameFormatted}</strong></c:otherwise>
                                        </c:choose>
                                    </span></a>
                                </h3>
                            </div>
                        </div> 
                    </c:if>
                </div>
            </div><!-- end column-one -->
            <div id="column-two">
                <div class="toggle section no-padding-bottom">
                    <div id="status" class="status">
                        <c:if test="${extendedTaxonConcept.taxonConcept.rankID >= 7000}">
                            <c:choose>
                                <c:when test="${extendedTaxonConcept.isAustralian}">
                                    <div id="iucn_div"><span class="iucn native">&nbsp;</span>Recorded In Australia</div>
                                </c:when>
                                <c:otherwise>
                                    <div id="iucn_div"><span class="iucn nonnative">&nbsp;</span>Not Recorded In Australia</div>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <c:forEach var="habitat" items="${extendedTaxonConcept.habitats}">
                            <c:set var="divMarine">
                                <div><span class="iucn marine">&nbsp;</span>Marine Habitats</div>
                            </c:set>
                            <c:set var="divTerrestrial">
                                <div><span class="iucn terrestrial">&nbsp;</span>Terrestrial Habitats</div>
                            </c:set>
                            <c:choose>
                                <c:when test="${habitat.status == 'M'}">${divMarine}</c:when>
                                <c:when test="${habitat.status == 'N'}">${divTerrestrial}</c:when>
                                <c:otherwise>${divMarine} ${divTerrestrial}</c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:forEach var="status" items="${extendedTaxonConcept.conservationStatuses}">
                            <c:if test="${fn:containsIgnoreCase(status.status,'extinct') || fn:containsIgnoreCase(status.status,'endangered') || fn:containsIgnoreCase(status.status,'vulnerable') || fn:containsIgnoreCase(status.status,'threatened') || fn:containsIgnoreCase(status.status,'concern') || fn:containsIgnoreCase(status.status,'deficient')}">
                                <c:set var="regionCode">
                                    <c:choose>
                                        <c:when test="${not empty status.region}">${status.region}</c:when>
                                        <c:otherwise>IUCN</c:otherwise>
                                    </c:choose>
                                </c:set>
                                <div><a href="${threatenedSpeciesCodes}#${statusRegionMap[regionCode]}" title="Threatened Species Codes - details" target="_blank">
                                    <c:choose>
                                        <c:when test="${fn:endsWith(status.status,'Extinct')}"><span class="iucn red"><fmt:message key="region.${regionCode}"/><!--EX--></span></c:when>
                                        <c:when test="${fn:containsIgnoreCase(status.status,'wild')}"><span class="iucn red"><fmt:message key="region.${regionCode}"/><!--EW--></span></c:when>
                                        <c:when test="${fn:containsIgnoreCase(status.status,'Critically')}"><span class="iucn yellow"><fmt:message key="region.${regionCode}"/><!--CR--></span></c:when>
                                        <c:when test="${fn:startsWith(status.status,'Endangered')}"><span class="iucn yellow"><fmt:message key="region.${regionCode}"/><!--EN--></span></c:when>
                                        <c:when test="${fn:containsIgnoreCase(status.status,'Vulnerable')}"><span class="iucn yellow"><fmt:message key="region.${regionCode}"/><!--VU--></span></c:when>
                                        <c:when test="${fn:containsIgnoreCase(status.status,'Near')}"><span class="iucn green"><fmt:message key="region.${regionCode}"/><!--NT--></span></c:when>
                                        <c:when test="${fn:containsIgnoreCase(status.status,'concern')}"><span class="iucn green"><fmt:message key="region.${regionCode}"/><!--LC--></span></c:when>
                                    </c:choose>
                                    ${status.rawStatus}</a>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div> 
                    <p class="trigger left no-padding-bottom" style="display: none"><a href="#">View all statuses</a></p>
                </div>

                <div id="images" class="section">

                    <ul>
                        <c:choose>
                            <c:when test="${not empty extendedTaxonConcept.taxonConcept.rankID && extendedTaxonConcept.taxonConcept.rankID < 7000}">
                                <c:set var="imageLimit" value="6"/>
                                <c:set var="imageSize" value="150"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="imageLimit" value="1"/>
                                <c:set var="imageSize" value="314"/>
                            </c:otherwise>
                        </c:choose>
                        <c:forEach var="image" items="${extendedTaxonConcept.images}" varStatus="status">
                            <c:set var="imageSrc" value="${fn:replace(image.repoLocation, '/raw.', '/smallRaw.')}"/>
                            <c:if test="${status.index < imageLimit}">
                                <li>
                                    <a href="${status.index}" title=""><img src="${imageSrc}" class="overviewImage" style="max-width: ${imageSize}px" alt="" /></a>
                                    <c:if test="${not empty image.creator}">
                                        <cite>Image by: ${image.creator}
                                            <c:if test="${not empty image.rights}">
                                            <br/>Rights: ${image.rights}
                                            </c:if>
                                            <br/><alatag:imageSourceURL image="${image}"/>
                                        </cite>
                                    </c:if>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
                <c:choose>
                    <c:when test="${not empty descriptionBlock}">
                        <div class="section buttons sighting no-margin-top">
                            <div class="last">
                                <h3>
                                    <a href="#contributeOverlay" class="contributeLink">Share <span>Sightings, photos and data for
                                        <c:choose>
                                            <c:when test="${not empty extendedTaxonConcept.commonNames}">
                                                the <strong>${extendedTaxonConcept.commonNames[0].nameString}</strong>
                                            </c:when>
                                            <c:otherwise>
                                                <c:if test="${extendedTaxonConcept.taxonConcept.rankID <= 6000}">the ${extendedTaxonConcept.taxonConcept.rankString} </c:if><strong>${extendedTaxonConcept.taxonConcept.nameString}</strong>
                                            </c:otherwise>
                                        </c:choose></span>
                                    </a>
                                </h3>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="section buttons sighting no-margin-top">
                            <div>
                                <h3><a href="#contributeOverlay" class="contributeLink">Can you help us?
                                    <span><b>Share</b> sightings, photos and data for
                                        <c:choose>
                                            <c:when test="${not empty extendedTaxonConcept.commonNames}">the <strong>${extendedTaxonConcept.commonNames[0].nameString}</strong></c:when>
                                            <c:otherwise><c:if test="${extendedTaxonConcept.taxonConcept.rankID <= 6000}">the ${extendedTaxonConcept.taxonConcept.rankString} </c:if><strong>${sciNameFormatted}</strong></c:otherwise>
                                        </c:choose>
                                    </span></a>
                                </h3>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="section">
                </div><!--close tools-->
            </div><!--close -->
        </div><!--close overview-->

        <c:if test="${not empty extendedTaxonConcept.screenshotImages || not empty extendedTaxonConcept.images}">
        <div id="gallery">
            <div id="column-one">
                <div class="section">
                    <h2>Images</h2>
                    <div id="imageGallery">
                    	<script type="text/javascript">
                    		function rankThisImage(guid, encodedUri, infosourceId, documentId, blackList, positive, name){
                    			//var encodedUri = escape(uri); 
                    			var url = "${pageContext.request.contextPath}/rankTaxonImage${not empty pageContext.request.remoteUser ? 'WithUser' : ''}?guid="+guid+"&uri="+encodedUri+"&infosourceId="+infosourceId+"&blackList="+blackList+"&positive="+positive+"&name="+name;
                       			 $('.imageRank-'+documentId).html('Sending your ranking....');
				                 $.getJSON(url, function(data){ })
			                	 $('.imageRank-'+documentId).each(function(index) {
								   $(this).html('Thanks for your help!');
						         });
	                         }
                    		
                    		function editThisImage(guid, uri){
                    			var url = "${pageContext.request.contextPath}/admin/edit?guid="+guid+"&uri="+uri;
                    			window.open(url);
                    			}

                    	</script>
                        <c:choose>
                            <c:when test="${not empty extendedTaxonConcept.images}">
                                <c:forEach var="image" items="${extendedTaxonConcept.images}" varStatus="status">
                                    <c:set var="thumbUri">${image.thumbnail}</c:set>
                                    <c:set var="imageUri">
                                        <c:choose>
                                            <c:when test="${not empty image.repoId}">images/${image.repoId}.jpg</c:when>
                                            <c:otherwise>${image.repoLocation}</c:otherwise>
                                        </c:choose>
                                    </c:set>
                                    <a class="thumbImage" rel="thumbs" title="${image.title}" href="${imageUri}" id="thumb${status.index}"><img src="${thumbUri}" alt="${image.infoSourceName}" title="${imageTitle}" width="100px" height="100px" style="width:100px;height:100px;padding-right:3px;"/></a>
                                    <div id="thumbDiv${status.index}" style="display:none;">
                                        <c:if test="${not empty image.title}">
                                            ${image.title}<br/>
                                        </c:if>
                                        <c:if test="${not empty image.creator}">
                                            Image by: ${image.creator}<br/>
                                        </c:if>
                                        <c:if test="${not empty image.locality}">
                                            Locality: ${image.locality}<br/>
                                        </c:if>
                                        <c:if test="${not empty image.licence}">
                                            Licence: ${image.licence}<br/>
                                        </c:if>
                                        <c:if test="${not empty image.rights}">
                                            Rights: ${image.rights}<br/>
                                        </c:if>
                                        <c:set var="imageUri">
                                            <c:choose>
                                                <c:when test="${not empty image.isPartOf}">
                                                    ${image.isPartOf}
                                                </c:when>
                                                <c:when test="${not empty image.identifier}">
                                                    ${image.identifier}
                                                </c:when>
                                                <c:otherwise>
                                                    ${image.infoSourceURL}
                                                </c:otherwise>
                                            </c:choose>
                                        </c:set>
                                        <c:choose>
                                        <c:when test="${image.infoSourceURL == 'http://www.ala.org.au'}">
                                            <cite>Source: ${image.infoSourceName}</cite>
                                         </c:when>
                                         <c:when test="${image.infoSourceURL == 'http://www.elfram.com/'}">
                                            <cite>Source: <a href="${image.infoSourceURL}" target="_blank">${image.infoSourceName}</a></cite>
                                         </c:when>                                         
                                         <c:otherwise>
                                         <c:choose>
                                         <c:when test="${not empty image.occurrenceUid}">
                                            <cite>
                                            	Source: <a href="${image.infoSourceURL}" target="_blank">${image.infoSourceName}</a>
                                            </cite>
                                         </c:when>                                         
                                         <c:otherwise>
                                         	<cite>Source: <a href="${imageUri}" target="_blank">${image.infoSourceName}</a></cite>
                                         </c:otherwise>
                                         </c:choose>
                                         </c:otherwise>
                                        </c:choose>
                                        
										<c:if test="${not empty image.occurrenceUid}">
										    <cite>
                                            	Biocache Occurrence UID: <a href="http://biocache.ala.org.au/occurrences/${image.occurrenceUid}" target="_blank">${image.occurrenceUid}</a>
                                            </cite>										
										</c:if>
                                        
<p class="imageRank-${image.documentId}">
									<cite>
                                     	<c:choose>
                                     		<c:when test="${not isReadOnly}">
                                     	                                    	
                                        <c:choose>
	                                        <c:when test="${fn:contains(rankedImageUris,image.identifier)}">
    	                                    	You have ranked this image as 
    	                                    		<c:if test="${!rankedImageUriMap[image.identifier]}">
    	                                    			NOT
    	                                    		</c:if>
  	                                    			representative of ${extendedTaxonConcept.taxonConcept.nameString}
</p>
</cite> 
        	                                </c:when>
            	                            <c:otherwise>
            	                            	Is this image representative of ${extendedTaxonConcept.taxonConcept.rankString} ?  
   	            	                           <a class="isrepresent" href="javascript:rankThisImage('${extendedTaxonConcept.taxonConcept.guid}','<string:encodeUrl>${image.identifier}</string:encodeUrl>','${image.infoSourceId}','${image.documentId}',false,true,'${extendedTaxonConcept.taxonConcept.nameString}');"> 
   	            	                           	  YES
   	            	                           </a>
   	            	                           	 |
   	            	                           <a class="isnotrepresent" href="javascript:rankThisImage('${extendedTaxonConcept.taxonConcept.guid}','<string:encodeUrl>${image.identifier}</string:encodeUrl>','${image.infoSourceId}','${image.documentId}',false,false,'${extendedTaxonConcept.taxonConcept.nameString}');"> 
   	            	                           	  NO
   	            	                           </a>
                                	       </cite> 
   	            	                           <c:if test="${not empty isRoleAdmin && isRoleAdmin}"> 
         	                           
   	            	                           <a class="isnotrepresent" href="javascript:rankThisImage('${extendedTaxonConcept.taxonConcept.guid}','<string:encodeUrl>${image.identifier}</string:encodeUrl>','${image.infoSourceId}','${image.documentId}',true,false,'${extendedTaxonConcept.taxonConcept.nameString}');"> 
   	            	                           	  BlackList
   	            	                           </a>
   	            	                           |
												<a class="isnotrepresent" href="#" onClick="editThisImage('${extendedTaxonConcept.taxonConcept.guid}','<string:encodeUrl>${image.identifier}</string:encodeUrl>');return false;">
													Edit
												</a>

   	            	                           </c:if>
</p>   	            	                           
                            	            </c:otherwise>
                                	        </c:choose>
                                	        
                                	        </c:when>
                                     		<c:otherwise>
                                     			<br/>
                                     			<b>Read Only Mode</b>
</p>                                     			
                                     		</c:otherwise>
                                     	</c:choose>
                                     	                                     	                                  	      
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                There are no images for this taxon.
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <h2 style="margin-top:40px;">Videos</h2>
                    <div id="imageGallery">
                        <c:choose>
                            <c:when test="${not empty extendedTaxonConcept.screenshotImages}">
                                <c:forEach var="screenshot" items="${extendedTaxonConcept.screenshotImages}" varStatus="status">
<!--                                    ${screenshot.repoLocation}-->
<!--                                    ${screenshot.thumbnail}-->
                                    <c:set var="thumbUri">${screenshot.repoLocation}</c:set>
                                    <c:set var="screenshotUri">
                                            <c:choose>
                                                
                                                <c:when test="${not empty screenshot.identifier}">
                                                    ${screenshot.identifier}
                                                </c:when>
                                                <c:when test="${not empty screenshot.isPartOf}">
                                                    ${screenshot.isPartOf}
                                                </c:when>
                                                <c:otherwise>
                                                    ${screenshot.infoSourceURL}
                                                </c:otherwise>
                                            </c:choose>
                                        </c:set>
                                    <table>
                                    	<tr>
                                    		<td>	
                                    			<a class="screenshotThumb" title="${screenshot.title}" href="${screenshotUri}" target="_blank"><img src="${thumbUri}" alt="${screenshot.infoSourceName}" title="${imageTitle}" width="120px" height="120px" style="width:120px;height:120px;padding-right:3px;"/></a>
                                    		</td>
                                    		<td>
                                      			<c:if test="${not empty screenshot.title}">
                                            		${screenshot.title}<br/>
                                        		</c:if>
                                        		<c:if test="${not empty screenshot.creator}">
                                            		Video by: ${screenshot.creator}<br/>
                                        		</c:if>
                                        		<c:if test="${not empty screenshot.locality}">
                                            		Locality: ${screenshot.locality}<br/>
                                        		</c:if>
                                        		<c:if test="${not empty screenshot.licence}">
                                            		Licence: ${screenshot.licence}<br/>
                                        		</c:if>
                                        		<c:if test="${not empty screenshot.rights}">
                                            		Rights: ${screenshot.rights}<br/>
                                        		</c:if>
                                        
                                            	Source: <a href="${screenshotUri}" target="_blank">${screenshot.infoSourceName}</a>
                                            </td>
                                       	</tr>
                                        
                                       	</table>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                There are no videos for this taxon.
                            </c:otherwise>
                        </c:choose>
                    
                    </div>
                </div>
            </div><!---->
            <div id="column-two">
                <div class="section buttons sighting no-margin-top">
                    <div class="last">
                        <h3><a href="#contributeOverlay" class="contributeLink">Share <span>Sightings, photos and data for the
                        	<strong>
                        		<c:choose>
                        		<c:when test="${not empty extendedTaxonConcept.commonNames}">
                        			${extendedTaxonConcept.commonNames[0].nameString}
                        		</c:when>
                        		<c:otherwise>
                        			${extendedTaxonConcept.taxonConcept.nameString}
                        		</c:otherwise>
                        		</c:choose>
                        	</strong>
                        	</span>
                       	 </a>
                        </h3>
                    </div>
                </div>
                <c:if test="${not empty extendedTaxonConcept.taxonConcept.rankID && extendedTaxonConcept.taxonConcept.rankID < 7000}">
                <div class="section">
                    <ul>
                    <li>
                    <a href="${pageContext.request.contextPath}/image-search/showSpecies?taxonRank=${extendedTaxonConcept.taxonConcept.rankString}&scientificName=${extendedTaxonConcept.taxonConcept.nameString}">
                        View images of species for ${sciNameFormatted}

                    </a>
                    </li>
                    </ul>
                </div><!--close-->
                </c:if>
            </div><!--close -->
        </div><!--close multimedia-->
        </c:if>
        <%--<div id="identification">
            <div id="column-one">
                <div class="section">
                    <h2>Identification</h2>
                    <h3>Description</h3>
                    <c:forEach var="textProperty" items="${textProperties}" varStatus="status">
                        <c:set var="sectionName" value="${fn:substringAfter(textProperty.name, '#')}"/><!-- ${sectionName} -->
                        <c:if test="${fn:containsIgnoreCase(sectionName, 'descriptive')}">
                            <p>${textProperty.value}
                                <cite>source: <a href="${textProperty.identifier}" target="_blank" title="${textProperty.title}">${textProperty.infoSourceName}</a></cite>
                            </p>
                        </c:if>
                    </c:forEach>
                </div><!--close section-->
            </div><!---->
            <div id="column-two">
                <div class="section tools">
                    <h3 class="contribute">Contribute</h3>
                    <ul>
                        <li><a href="">Images</a></li>
                        <li><a href="">Data</a></li>
                        <li><a href="">Links</a></li>
                    </ul>
                </div><!--close tools-->
                <div class="section">
                    <h2></h2>
                </div><!--close-->
            </div><!--close -->
        </div><!--close identification-->--%>
        <div id="names">
            <div id="column-one">
                <div class="section">
                    <h2>Accepted Name</h2>
					<%-- 
                     <p>${sciNameFormatted} ${extendedTaxonConcept.taxonConcept.author}
                        <cite>Source: <a href="${extendedTaxonConcept.taxonConcept.infoSourceURL}" target="blank">${extendedTaxonConcept.taxonConcept.infoSourceName}</a></cite>
                        <c:if test="${not empty extendedTaxonConcept.taxonName.publishedIn}"><cite>Published in: <a href="#">${extendedTaxonConcept.taxonName.publishedIn}</a></cite></c:if>
                    </p>
                  	--%>
                    <table>
                    	<tr>
                            <td>${sciNameFormatted} ${authorship}</td>
                            <td class="source">
                                <cite>Source:&nbsp;<a href="${extendedTaxonConcept.taxonConcept.infoSourceURL}" target="blank">${extendedTaxonConcept.taxonConcept.infoSourceName}</a></cite>
                            </td>
                    	</tr>
                    	<tr class="cite">
                            <td colspan="2">
                                    <c:if test="${not empty extendedTaxonConcept.taxonName.publishedIn}"><cite>Published in: <a href="#">${extendedTaxonConcept.taxonName.publishedIn}</a></cite></c:if>
                            </td>
                    	</tr>
                    	<tr class="cite">
                            <td colspan="2">
                                    <c:if test="${not empty extendedTaxonConcept.taxonConcept.referencedIn}"><cite>Referenced in: <a href="#">${extendedTaxonConcept.taxonConcept.referencedIn}</a></cite></c:if>
                            </td>
                    	</tr>
                    	<!--  Add all the sameAs TaxonConcepts as publicationn -->
                    	<c:if test="${not empty extendedTaxonConcept.sameAsConcepts}">
                    		<c:forEach items="${extendedTaxonConcept.sameAsConcepts}" var="sameConcept">
                    			<c:if test="${not empty sameConcept.publishedIn}">
                    				<tr class="cite">
                            			<td colspan="2">
                            				<cite>Published in: <span class="publishedIn">${sameConcept.publishedIn}</span></cite>
                            			</td>
                            		</tr>
                    			</c:if>
                    			<c:if test="${not empty sameConcept.referencedIn}">
                      				<tr class="cite">
                            			<td colspan="2">
                            				<cite>Referenced in: <span class="publishedIn">${sameConcept.referencedIn}</span></cite>
                            			</td>
                            		</tr>                  			
                    			</c:if>
                    		</c:forEach>
                    	</c:if>
                    </table>

                    <c:if test="${not empty extendedTaxonConcept.synonyms}">
                    <c:set var="currentNameLsid">empty</c:set>
                        <h2>Synonyms</h2>
                        <table>
                    </c:if>
                    <c:forEach items="${extendedTaxonConcept.synonyms}" var="synonym">
                    	<c:if test="${synonym.nameGuid != currentNameLsid}">
                    	<c:set var="currentNameLsid">${synonym.nameGuid}</c:set>
                    	<tr>                    		
                            <td><alatag:formatSciName name="${synonym.nameString}" rankId="${extendedTaxonConcept.taxonConcept.rankID}"/> ${synonym.author}</td>
                            <td class="source">
                                <c:choose>
                                    <c:when test="${empty synonym.infoSourceURL}"><cite>Source:&nbsp;<a href="${extendedTaxonConcept.taxonConcept.infoSourceURL}" target="blank">${extendedTaxonConcept.taxonConcept.infoSourceName}</a></cite></c:when>
                                    <c:otherwise><cite>Source:&nbsp;<a href="${synonym.infoSourceURL}" target="blank">${synonym.infoSourceName}</a></cite></c:otherwise>
                                </c:choose>
                            </td>
                             <td>(${synonym.relationship} ${synonym.description})</td> 
                        </tr>
                        </c:if>
                        <tr class="cite">
                            <td colspan="2">
                                <c:if test="${not empty synonym.publishedIn}"><cite>Published in: <span class="publishedIn">${synonym.publishedIn}</span></cite></c:if>
                            </td>
                        </tr>
                        <tr class="cite">
                            <td colspan="2">
                                <c:if test="${not empty synonym.referencedIn}"><cite>Referenced in: <span class="publishedIn">${synonym.referencedIn}</span></cite></c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${not empty extendedTaxonConcept.synonyms}">
                        </table>
                    </c:if>                    
                    <c:if test="${not empty extendedTaxonConcept.commonNames}">
                    	<script type="text/javascript">
                    		function rankThisCommonName(guid, documentId, blackList, positive, name) {
                                var url = "${pageContext.request.contextPath}/rankTaxonCommonName${not empty pageContext.request.remoteUser ? 'WithUser' : ''}?guid="+guid+"&blackList="+blackList+"&positive="+positive+"&name="+name;
								var linkId = 'cnRank-'+documentId;
                    			$('#cnRank-'+documentId).html('Sending your ranking....');
				                var jqxhr = $.getJSON(url, function(data){
                                    $('#cnRank-'+documentId).each(function(index) {
                                        $(this).html('Thanks for your help!');
                                    });
				                }).error(function(jqXHR, textStatus, errorThrown) {
                                    // catch ajax errors (requiers JQuery 1.5+) - usually 500 error
                                    $('#cnRank-'+documentId).html('An error occurred: ' + errorThrown + " (" + jqXHR.status + ")");
                                });
	                        }
                    	</script>
                        <h2>Common Names</h2>
                        <table>
                    </c:if>
                    <c:forEach items="${sortCommonNameKeys}" var="nkey">
                    	<c:set var="cNames" value="${sortCommonNameSources[nkey]}" />
                    	<%-- special treatment for <div> id and cookie name/value. matchup with Ranking Controller.rankTaxonCommonNameByUser --%>                      	
                      	<c:set var="fName" value='<%= ((String)pageContext.getAttribute("nkey")).trim().hashCode() %>' />
                    	
                    	<%-- jacascript treatment: manual translate special charater, because string:encodeURL cannot handle non-english character --%>
                    	<c:set var="enKey" value='<%= org.apache.commons.lang.StringEscapeUtils.escapeJavaScript(pageContext.getAttribute("nkey").toString()) %>' />
                    	
                    	<tr>
                            <td>
                            	${nkey}                    	

<c:choose>
<c:when test="${not isReadOnly}">						
							
							<c:choose>
                            <c:when test="${fn:contains(rankedImageUris,fName)}">
                            <p>  
                            <%--                          
                            	You have ranked this Common Name as 
                            		<c:if test="${!rankedImageUriMap[fName]}">
                            			NOT
                            		</c:if>
                          			representative of ${extendedTaxonConcept.taxonConcept.nameString}
                          			 --%>
                          			</p>
                            </c:when>
                            <c:otherwise>                            	
                            	<c:if test="${not empty cNames}">
                                    <div id='cnRank-${fName}' class="rankCommonName">
	       	                            	Is this a preferred common name for this ${extendedTaxonConcept.taxonConcept.rankString}?
	           	                           <a class="isrepresent" href="#" onclick="rankThisCommonName('<string:encodeUrl>${extendedTaxonConcept.taxonConcept.guid}</string:encodeUrl>','${fName}',false,true,'${fn:trim(enKey)}');return false;">YES</a>
                                            |
	           	                           <a class="isnotrepresent" href="#" onclick="rankThisCommonName('<string:encodeUrl>${extendedTaxonConcept.taxonConcept.guid}</string:encodeUrl>','${fName}',false,false,'${fn:trim(enKey)}');return false;">NO</a>
                                	</div>
                                </c:if> 
                                </c:otherwise>
                                </c:choose>
                                
</c:when>
<c:otherwise>
<div id='cnRank-${fName}' class="rankCommonName">
Read Only Mode
</div>
</c:otherwise>
</c:choose>
                                                         
                            </td>
                            <td class="source">
                                <c:forEach items="${sortCommonNameSources[nkey]}" var="commonName">
                                    <c:choose>
                                        <c:when test="${not empty commonName.identifier && not empty commonName.infoSourceName}"><cite>Source: <a href="${commonName.identifier}" target="blank">${commonName.infoSourceName}</a></cite></c:when>
                                        <c:otherwise><cite>Source:&nbsp;<a href="${commonName.infoSourceURL}" target="blank">${commonName.infoSourceName}</a></cite></c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </td>
                    	</tr>
                    </c:forEach> 
                    <c:if test="${not empty extendedTaxonConcept.commonNames}">
                        </table>
                    </c:if>                                     
                </div>
            </div><!---->
            <div id="column-two">
                <div class="section">
                </div>
            </div><!--close -->
        </div><!--close names-->
        <div id="classification">
            <div id="column-one">
                <div class="section">
                    <h2>Scientific Classification</h2>
                    <div id="isAustralianSwitch"></div>
                    <div id="classificationList">
                    	<c:forEach items="${taxonHierarchy}" var="taxon">
                            <c:choose><%-- Note: check for rankId is here due to some taxonHierarchy including taxa at higher rank than requested taxon (bug) --%>
                                <c:when test="${taxon.rankId <= extendedTaxonConcept.taxonConcept.rankID && taxon.guid != extendedTaxonConcept.taxonConcept.guid}">
                                    <ul><li>${taxon.rank}: <a href="<c:url value='/species/${taxon.guid}#classification'/>" title="${taxon.rank}">
                                        <alatag:formatSciName name="${not empty taxon.nameComplete ? taxon.nameComplete : taxon.name}" rankId="${taxon.rankId}"/>
                                        <c:if test="${not empty taxon.commonNameSingle && taxon.guid == extendedTaxonConcept.taxonConcept.guid}">
                                            : ${taxon.commonNameSingle}
                                        </c:if>
                                    </a></li>
                                </c:when>
                                <c:when test="${taxon.guid == extendedTaxonConcept.taxonConcept.guid}">
                                    <ul><li id="currentTaxonConcept">${taxon.rank}: <span><alatag:formatSciName name="${not empty taxon.nameComplete ? taxon.nameComplete : taxon.name}" rankId="${taxon.rankId}"/>
                                    <c:if test="${not empty taxon.commonNameSingle && taxon.guid == extendedTaxonConcept.taxonConcept.guid}">
                                            : ${taxon.commonNameSingle}
                                        </c:if></span>
                                        <c:if test="${not empty taxon.isAustralian || extendedTaxonConcept.isAustralian}">
                                            &nbsp;<span id="recordedIn"><img src="${pageContext.request.contextPath}/static/images/au.gif" alt="Recorded in Australia" class="no-rounding" title="Recorded in Australia"/></span>
                                        </c:if>
                                        </li>
                                </c:when>
                                <c:otherwise><!-- Taxa ${taxon.guid} - ${taxon.name} (${taxon.rank}) should not be here! --></c:otherwise>
                            </c:choose>
                    	</c:forEach>
                        <ul class="childClassification">
                            <c:forEach items="${childConcepts}" var="child">
                                <li class="${child.isAustralian}">${child.rank}:
                                    <c:set var="taxonLabel">
                                        <alatag:formatSciName name="${not empty child.nameComplete ? child.nameComplete : child.name}" rankId="${child.rankId}"/>
                                        <c:if test="${not empty child.commonNameSingle}">: ${child.commonNameSingle}</c:if>
                                    </c:set>
                                    <a href="<c:url value='/species/${child.guid}#classification'/>">${fn:trim(taxonLabel)}</a>&nbsp;
                                    <span id="recordedIn">
                                        <c:choose>
                                            <c:when test="${not empty child.isAustralian}">
                                                <img src="${pageContext.request.contextPath}/static/images/au.gif" alt="Recorded in Australia" class="no-rounding" title="Recorded in Australia"/>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="inferredPlacement" title="Not recorded in Australia">[inferred placement]</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </li>
                            </c:forEach>
                        </ul>
                        <c:forEach items="${taxonHierarchy}" var="taxon">
                            </ul>
                        </c:forEach>
                    </div>
                </div>
            </div><!---->
            <div id="column-two">
                <div class="section">

                </div>
            </div><!--close -->
        </div><!--close classification-->
        <div id="records">
            <div id="column-one">
                <div class="section">
                    <h2>Occurrence Records</h2>
                    <div id="occurrenceRecords">
                        <p><a href="${biocacheUrl}occurrences/taxa/${extendedTaxonConcept.taxonConcept.guid}">View
                                list of all <span id="occurenceCount"></span> occurrence records for this taxon</a></p>
                        <div id="recordBreakdowns" style="display: block">
                        </div>
                    </div>
                                
                    <%-- Distribution map images --%>
                    <c:if test="${not empty extendedTaxonConcept.distributionImages}">
                        <h2>Record maps from other sources</h2>
                        <c:forEach items="${extendedTaxonConcept.distributionImages}" var="distribImage">
                            <div class="recordMapOtherSource" style="display: block">
                                <c:set var="imageLink">${not empty distribImage.isPartOf ? distribImage.isPartOf : distribImage.infoSourceURL}</c:set>
                                <a href="${imageLink}">
                                    <img src="${distribImage.repoLocation}" alt="3rd party distribution map"/>
                                </a>
                                <br/>
                                <cite>Source:
                                    <a href="${imageLink}" target="blank">${distribImage.infoSourceName}</a>
                                </cite>
                            </div>
                        </c:forEach>
                    </c:if>
                    <%--
                    <c:forEach var="regionType" items="${extendedTaxonConcept.regionTypes}">
                        <c:if test="${fn:containsIgnoreCase(regionType.regionType, 'state') || fn:containsIgnoreCase(regionType.regionType, 'territory')}">
                            <h4>${regionType.regionType}</h4>
                            <ul style="list-style-type: circle;">
                                <c:forEach var="region" items="${regionType.regions}">
                                    <li>${region.name}:
                                        <a href="${biocacheUrl}occurrences/searchByTaxon?q=${extendedTaxonConcept.taxonConcept.guid}&fq=state:${region.name}">${region.occurrences}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:if>
                    </c:forEach>
                    <c:forEach var="regionType" items="${extendedTaxonConcept.regionTypes}">
                        <c:if test="${fn:containsIgnoreCase(regionType.regionType, 'ibra') || fn:containsIgnoreCase(regionType.regionType, 'imcra')}">
                            <h4>${regionType.regionType}</h4>
                            <ul style="list-style-type: circle;">
                                <c:forEach var="region" items="${regionType.regions}">
                                    <li>${region.name}: ${region.occurrences}</li>
                                </c:forEach>
                            </ul>
                        </c:if>
                    </c:forEach> --%>
                </div>
            </div><!---->
            <div id="column-two">
                <div class="section buttons sighting no-margin-top">
                    <div class="last">
                        <h3><a href="#contributeOverlay" class="contributeLink">Share <span>Sightings, photos and data for the
                                <strong>
                                    <c:choose>
                                        <c:when test="${not empty extendedTaxonConcept.commonNames}">
                                            ${extendedTaxonConcept.commonNames[0].nameString}
                                        </c:when>
                                        <c:otherwise>
                                            ${extendedTaxonConcept.taxonConcept.nameString}
                                        </c:otherwise>
                                    </c:choose>
                                </strong>
                            </span></a>
                        </h3>
                    </div>
                   <div id="alerts"></div>
				   <script type="text/javascript">
							function alertsCallback(data){
							  if(data.alertExists){
								   $('#alerts').html('<div class="last"><h3><a href="'+data.link+'" class="emailLink">Email alerts<span>You have an alert setup for <strong>'+data.name+'</strong>. Click here to manage your alerts</span></a></h3></div>');
							  } else {
								    $('#alerts').html('<div class="last"><h3><a href="'+data.link+'" class="emailLink">Email alerts<span>Notify me when new records come online for <strong>'+data.name+'</strong></span></a></h3></div>');
							  }
							}
					</script>
					<script type="text/javascript" 
							src="http://alerts.ala.org.au/webservice/taxonAlerts?ts=<%= java.lang.System.currentTimeMillis() %>&userId=${pageContext.request.remoteUser}&guid=${extendedTaxonConcept.taxonConcept.guid}&taxonName=${pageName}&redirect=http://bie.ala.org.au/species/${extendedTaxonConcept.taxonConcept.guid}#Records">
					</script>
				</div>	
                <div class="section">
                    <c:if test="${not empty spatialPortalMap && !fn:containsIgnoreCase(spatialPortalMap.mapUrl, 'mapaus1_white')}">
                        <div class="distroMap">
                            <h4>Map of Occurrence Records</h4>
                            <p>
                                <a href="${spatialPortalUrl}?species_lsid=${extendedTaxonConcept.taxonConcept.guid}" title="view in mapping tool" target="_blank">
                                    <img src="${spatialPortalMap.mapUrl}" class="distroImg" alt="" width="300" style="margin-bottom:-30px;"/></a><br/>
                                <a href="${spatialPortalUrl}?species_lsid=${extendedTaxonConcept.taxonConcept.guid}" title="view in mapping tool" target="_blank">Interactive version of this map</a>
                            </p>
                        </div>
                    </c:if>
                    <c:if test="${not empty extendedTaxonConcept.specimenHolding}">
                        <div class="section">
                            <h3>Specimen Holdings</h3>
                            <ul>
                                <c:forEach var="specimenHolding" items="${extendedTaxonConcept.specimenHolding}">
                                    <%--
                                    <li><a href="${specimenHolding.url}" target="_blank">${specimenHolding.institutionName}&nbsp;:&nbsp;${specimenHolding.siteName}</a> (specimens:&nbsp;${specimenHolding.count})</li>
                                     --%>
                                    <li><a href="${specimenHolding.url}" target="_blank">
                                    	<c:if test="${not empty specimenHolding.siteName}">
                                    		${specimenHolding.institutionName} &nbsp;:&nbsp;${specimenHolding.siteName}
                                    	</c:if>
                                    	<c:if test="${empty specimenHolding.siteName}">
                                    		${specimenHolding.institutionName}
                                    	</c:if>
                                    	</a></li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                </div><!--close-->
            </div><!--close -->
        </div><!--close records-->
<%--        <div id="biology">
            <div id="column-one">
                <div class="section">
                    <h2>Biology</h2>
                    <p></p>
                </div>
            </div><!---->
            <div id="column-two">
                <div class="section tools">
                    <h3 class="contribute">Contribute</h3>
                    <ul>
                        <li><a href="">Images</a></li>
                        <li><a href="">Data</a></li>
                        <li><a href="">Links</a></li>
                    </ul>
                </div><!--close tools-->
                <div class="section">
                    <h2></h2>
                </div><!--close-->
            </div><!--close -->
        </div><!--close biology-->
        <div id="molecular">
            <div id="column-one">
                <div class="section">
                    <h2>Molecular</h2>
                    <p></p>
                </div>
            </div><!---->
            <div id="column-two">
                <div class="section tools">
                    <h3 class="contribute">Contribute</h3>
                    <ul>
                        <li><a href="">Images</a></li>
                        <li><a href="">Data</a></li>
                        <li><a href="">Links</a></li>
                    </ul>
                </div><!--close tools-->
                <div class="section">
                    <h2></h2>
                </div><!--close-->
            </div><!--close -->
        </div><!--close molecular-->
--%>
        <c:if test="${not empty extendedTaxonConcept.references}">
        <div id="literature">
            <div id="column-one" class="full-width">
                <div class="section">
                    <h2>Literature</h2>
                    <div id="literature">
                        <c:if test="${not empty extendedTaxonConcept.earliestReference || not empty extendedTaxonConcept.references}">
                            <table class="propertyTable" >
                                <tr>
                                    <th>Scientific&nbsp;Name</th>
                                    <th>Reference</th>
                                    <th>Volume</th>
                                    <th>Author</th>
                                    <th>Year</th>
                                    <th>Source</th>
                                </tr>
                                <c:if test="${not empty extendedTaxonConcept.earliestReference}">
                                    <tr class="earliestReference">
                                        <td>${extendedTaxonConcept.earliestReference.scientificName}</td>
                                        <td>${extendedTaxonConcept.earliestReference.title}
                                            <br/><span class="earliestReferenceLabel">(Earliest reference within BHL)</span>
                                        </td>
                                        <td>${extendedTaxonConcept.earliestReference.volume}</td>
                                        <td>${extendedTaxonConcept.earliestReference.authorship}</td>
                                        <td>${extendedTaxonConcept.earliestReference.year}</td>
                                        <td><a href="http://bhl.ala.org.au/page/${extendedTaxonConcept.earliestReference.pageIdentifiers[0]}" title="view original publication" target="_blank">Biodiversity Heritage Library</a></td>
                                    </tr>
                                </c:if>
                                <c:forEach items="${extendedTaxonConcept.references}" var="reference">
                                    <tr>
                                        <td>${reference.scientificName}</td>
                                        <td>
                                            <span class="title">${reference.title}</span>
                                        </td>
                                        <td>
                                            <span class="volume"><c:if test="${not empty reference.volume && reference.volume!='NULL'}">${reference.volume}</c:if></span><br/>
                                        </td>
                                        <td>
                                            <span class="authorship">${reference.authorship}</span>
                                        </td>
                                        <td>
                                            <span class="year">${reference.year}</span>
                                        </td>
                                        <td><a href="http://bhl.ala.org.au/page/${reference.pageIdentifiers[0]}" title="view original publication" target="_blank">Biodiversity Heritage Library</a></td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </c:if>
                    </div>
                </div>
            </div><!---->
        </div><!--close references-->
        </c:if>
        <div style="display: none;"><!-- hidden div for fancybox pop-up share links -->
            <div id="contributeOverlay">
                <div class="section buttons no-borders no-margin-bottom" style="text-align: left !important">
                    <div class="sightings">
                    	<!-- changed to citizenScience url -->
                       	<!-- <h2><a href="${contributeURL}">Sightings <span>Record your observations of -->                     
                        <h2><a href="${citizenSciUrl}${extendedTaxonConcept.taxonConcept.guid}">Sightings <span>Record your observations of
                                <c:choose>
                                    <c:when test="${not empty extendedTaxonConcept.commonNames}">the <strong>${extendedTaxonConcept.commonNames[0].nameString}</strong></c:when>
                                    <c:otherwise><c:if test="${extendedTaxonConcept.taxonConcept.rankID <= 6000}">the ${extendedTaxonConcept.taxonConcept.rankString} </c:if><strong>${sciNameFormatted}</strong></c:otherwise>
                                </c:choose>
                            </span></a></h2>
                    </div>
                    <c:set var="wpParams">guid=${extendedTaxonConcept.taxonConcept.guid}&scientificName=${fn:replace(extendedTaxonConcept.taxonConcept.nameString,' ','+')}<c:if test="${not empty extendedTaxonConcept.commonNames}">&commonName=${fn:replace(extendedTaxonConcept.commonNames[0].nameString,' ','+')}</c:if></c:set>
                    <div class="photos">
                        <h2><a href="${initParam.centralServer}/share-images/?${wpParams}">Photos <span>Share your images with the Atlas</span></a></h2>
                    </div>
                    <div class="analogue-data">
                        <h2><a href="${initParam.centralServer}/share/share-links/?${wpParams}">Links, ideas, information <span>Share
                                    links, species page comments &amp; ideas</span></a></h2>
                    </div>
                    <div class="digital-data last">
                        <h2><a href="${initParam.centralServer}/share/share-data/">Datasets <span>Share your spreadsheets,
                            databases &amp; more</span></a></h2>
                    </div>
                </div><!--buttons-->
                <div class="section no-margin-top">
                    <p><!-- custom field deck extends the Share Title at the head of the page -->&nbsp;</p>
                    <p>Content shared with the Atlas is subject to
                        our <span class="asterisk-container"><a href="${initParam.centralServer}/about/terms-of-use/" title="Terms of Use">Terms of Use</a>.</span></p>
                </div><!--close section-->
            </div>
        </div>
    </body>
    <% request.setAttribute("jspTime", System.currentTimeMillis() - start); %>
</html>