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

class TreeViewerController {

    def index() { }

    def show() {
        def treeInstance = Tree.get(params.id)
        if (!treeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tree.label', default: 'Tree'), params.id])
            redirect(controller: "tree", action: "list")
            return
        }

        render(view: "treeViewer", model: [treeInstance: treeInstance])
    }
}
