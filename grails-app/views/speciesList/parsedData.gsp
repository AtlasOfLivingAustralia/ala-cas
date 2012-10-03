<%--
  - Copyright (C) 2012 Atlas of Living Australia
  - All Rights Reserved.
  -
  - The contents of this file are subject to the Mozilla Public
  - License Version 1.1 (the "License"); you may not use this file
  - except in compliance with the License. You may obtain a copy of
  - the License at http://www.mozilla.org/MPL/
  -
  - Software distributed under the License is distributed on an "AS
  - IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
  - implied. See the License for the specific language governing
  - rights and limitations under the License.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<div id="parsedData">
    <div id="tabulatedData">
    <style type="text/css">
      table { border-collapse: collapse;
          margin-bottom: 0px;}
      /*th { font-size: 12px; border-collapse: collapse; border: 1px solid #000000; padding:2px; background-color: #000000; color: #ffffff;}*/
      /*td { font-size: 11px; border-collapse: collapse; border: 1px solid #000000; padding: 2px;}*/
    </style>
    <h1> </h1>
        <div class="fwtable">
        <table id="initialParse">
           <thead>
           <g:if test="${columnHeaders}">
               <g:each in="${columnHeaders}" var="hdr">
                   <th class="parse">
                       <input id="Head_${hdr}"class="columnHeaderInput" type="text" value="${hdr}" style="${hdr.startsWith("UNKNOWN")? 'background-color: #E9AB17;':''}" onkeyup="javascript:window.setTimeout('updateH3(this.id)', 500, true);"/>
                   </th>
               </g:each>
           </g:if>
           </thead>
            <tbody>
            <g:each in="${dataRows}" var="row">
                <tr>
                    <g:each in="${row}" var="value">
                        <td class="parse">${value}</td>
                    </g:each>
                </tr>
            </g:each>
            </tbody>
        </table>
        </div>
    </div><!-- tabulatedData -->
    <g:if test="${listProperties}">
        <p>
        We have detected species properties within the list. It is possible to map your properties to a controlled vocabulary.
        <input id="viewVocabButton" class="datasetName" type="button" value="Click here to map..." onclick="javascript:viewVocab();"/>
        </p>
        <div class="allVocabs" id="listvocab">
        <g:each in="${listProperties.keySet()}" var="key">
            <div class="vocabDiv">
            <h3 class="vocabHeader" for="Head_${key}">${key}</h3>
                <div class="fhtable">
                    <table class="vocabularyTable" id="Voc_${key}" for="Head_${key}">
                        <thead>
                            <th class="parse">Value</th>
                            <th class="parse">Maps To</th>
                        </thead>
                        <tbody class="vocabBody">
                            <g:each in="${listProperties.get(key)}" var="rawKeyVal">
                                <tr>
                                <td class="parse">${rawKeyVal}</td>
                                <td class="parse"><input class="vocabHeader_${key}" type="text" value=""/></td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                 </div> <!-- div fhtable -->
            </div>
        </g:each>
        </div>
    </g:if>
</div>
