
* verify production mode with compiled assets

* I/P devise pages
    * login/session - new
    * registration - new edit
    * password - new edit
    * confirmation - new
    * unlock - new
    * devise demo - install sample controller, views and seeds
    
* Config flag to add gem's views & controllers to the appropriate rails path or not
    * sample gentelelall.rb config file

* I/P graphs on index page are broken - broken init_cropper
    * need to submit pull request to Gentelella
    * recommend adding log entry @ end of init_* code to say init is complete

* error page(s) - 403, 403, and 500
    * revise script and css references to the rails asset system
    
* Rails Code Examples
    * CRUD example
    * Chart that pulls data from a model via json fetch
    * In place editing of records
    * cable example for Dashboard indicator(s)

* I/P Datatable Example
    * I/P Index view
    * Inline record edit
    * New record add
    * Delete record

* DONE gentelella progress indicator fights with turbolinks progress indicator
    * Caused by failed init_X code

* Generator install:gentelella
    * add --no-routes option

Ideas
* partials, helpers and generators
* inspiration from http://wrapbootstrap.com/preview/WB0573SK0
* select what JS libraries / features are included or not
* strategy to extend with other JS libraries over time
* "digest" the custom.js into something a bit more modular and generalized (remove 'demo' type references)
* theme / skin strategy
* provide ActiveAdmin level functionality/features
* I18n throughout

KEY
 I/P   - in progress
 DONE  - committed
