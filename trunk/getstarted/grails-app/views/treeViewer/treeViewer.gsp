<%--
  Created by IntelliJ IDEA.
  User: nick
  Date: 8/08/12
  Time: 2:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Tree for ${treeInstance.name}</title>
    <meta name="layout" content="ala2"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'PhyloJive.css')}" type="text/css" media="screen" />

    <script type="text/javascript" src="${resource(dir: 'js', file: 'jit.js')}"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
    <script type="text/javascript" src="http://raw.github.com/jackmoore/colorbox/v1.3.16/colorbox/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="http://www.jsphylosvg.com/js/jsphylosvg-min.js"></script>
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.3.3/underscore-min.js"></script>
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/backbone.js/0.9.2/backbone-min.js"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'PhylogenyExplorer.js')}"></script>
    <!--[if IE]><script language="javascript" type="text/javascript" src="${resource(dir: 'js', file: 'excanvas.js')}"></script><![endif]-->
    <script type="text/javascript">
        $(document).ready(function() {
            var tree = "${treeInstance.newick}";
            init_phylojive(tree, {});
            loadCharacters();
        });

        function init_phylojive(tree, characters) {
            //console.log("getkey", getKey(characters), getKey(characters[getKey(characters)]));
            phylogenyExplorer_init({
                width: 600,
                height: 600,
                tree: tree,
                character: characters,
                codeBase: "${resource(dir: 'images')}",
                presentClade: function(clade) {
                    var tmpl = st.config.tmpl, nodeList = [], node, html, split;
                    for (var i = 0;
                         ((i < clade.length) & (i < 30)); i++) {
                        node = {}
                        node.name = clade[i].name;
                        node.plus = clade[i].name.replace(/\s+/g, '+');
                        split = node.name.split(/\s+/);
                        if (split.length > 1) {
                            node.genus = split[0];
                            node.species = split[1];
                        } else {
                            node.species = split[0];
                        }
                        node.rel = node.species + '' + i;
                        node.index = i;
                        nodeList.push(node);
                    }
                    if (tmpl) {
                        tmpl = _.template(tmpl);
                        html = tmpl({
                            nodeList: nodeList
                        });
                    } else {

                    }
                    return html;

                },
                //presentClade
                tmpl: '${treeInstance.popupTemplate}'
            });
        } // end init_phylojive

        function loadCharacters() {
            var nodes = [];
            var root = st.graph.getNode(st.root);
            root.eachSubgraph(function (node) {
                if (node.name) {
                    var sciName = node.name.replace(/\s+\d+/,""); // strip off year strings
                    //nodes[sciName] = node.name;
                    nodes.push(sciName);
                }
            });
            var joinedNames = nodes.join(";").replace(/\s+/g, "+");
            //console.log("joinedNames", joinedNames);
            var newChars = {};
            var url = "${createLink(controller: 'proxy', action: 'getCharacters')}?names=" + joinedNames + "&dataset=${treeInstance.identifyLifeDataset}";
            //console.log("url", url);
            jQuery.getJSON(url, function(data) {
                jQuery.each(data, function(key, el) {
                    //console.log("key:", key, el, nodes[key]);
                    newChars[key] = el;
                });
                var firstChar;
                for (var key in newChars) {
                    if (newChars[key]) {
                        firstChar = getKey(newChars[key]);
                        break;
                    }
                }

                //console.log("newChars", newChars, getKey(newChars), firstChar);
                st.config.firstCharacter = firstChar;
                st.character = newChars || {};
                //console.log("st 2", st);
                if (st.character) {
                    html = st.colorCharacter() || '';
                    jQuery('#legendBody').html(html);
                    //legendElem.style.display = 'inline';
                    jQuery('#legend').show();
                    updateCharacter(st.characterList);
                } else {
                    jQuery('#legend').hide();
                }
            }).error(function(jqXHR, textStatus, errorThrown){ alert("getJSON Error: " + textStatus);});
        }

        function getKey(data) {
            for (var prop in data)
                return prop;
        }

    </script>
</head>
<body>
<div id="content">
    <header id="page-header">
        <div class="inner">
            <nav id="breadcrumb">
                <ol>
                    <li><a href="http://www.ala.org.au">Home</a></li>
                    <li><a href="${createLink(uri: '/')}">Phylojive</a></li>
                    <li class="last">Tree Viewer</li>
                </ol>
            </nav>
            <h1>Tree for ${treeInstance.name}</h1>
        </div><!--inner-->
    </header>
    <div class="inner">
        <div id="section" class="col-wide">
            <div id="infovis"></div>
        </div>
    </div>
</div>
</body>
</html>