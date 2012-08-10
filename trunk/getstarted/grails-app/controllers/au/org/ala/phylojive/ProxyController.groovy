/*
 * Copyright (C) 2012 Atlas of Living Australia
 * All Rights Reserved.
 *
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 */
package au.org.ala.phylojive

class ProxyController {
    def webService

    def getCharacters() {
        def names = params.names.replaceAll(" ", "+")
        def dataset = params.dataset
        def url = grailsApplication.config.identifyLifeUrl + "?t=" + names + "&d=" + dataset
        def json = webService.get(url)

        if (params.callback) {
            render (contentType: "text/javascript", text: "${params.callback}(${json})")
        } else {
            render (contentType: "application/json", text: json)
        }
    }
}
