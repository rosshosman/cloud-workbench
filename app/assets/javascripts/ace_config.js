// For configuration also see: config/initializers/aced_rails.rb
// aced_rails docs: https://github.com/ffloyd/aced_rails
// ace editor docs:
// * HOWTO: http://ace.c9.io/#nav=howto
// * API Reference: https://github.com/ajaxorg/ace/wiki/Embedding-API

var tabSize = 2;
var wrapLimit = null;
var minHeight = 400;
// Make sure you import the theme and mode to use in application.js
var ace_theme = 'github';
var ace_mode = 'ruby';
var configure_ace_editor = function() {
    var textarea = $('#benchmark_definition_vagrantfile');
    if (textarea.exists()) {
        // Replace textarea with ace editor
        textarea.acedInitTA({ theme: ace_theme,
                              mode: ace_mode
        });

        // Dynamically resize the editor height
        var ace_div = $('.ace_editor');
        var set_height = function() {
            var height = Math.max(minHeight, $(window).innerHeight() * 0.7);
            ace_div.css({ height: height });
        };
        set_height();
        $(window).resize(function(){
            set_height();
        });

        // Configure editor
        var editor = textarea.data('ace-div').aced();
        var session = editor.getSession();
        session.setTabSize(tabSize);
        // Example how to set theme and mode via javascript
        //    editor.setTheme("ace/theme/monokai");
        //    session.setMode("ace/mode/ruby");

        // Soft wrapping
        session.setUseWrapMode(true);
        session.setWrapLimitRange(wrapLimit, wrapLimit);

        // Auto-completion
        require("ace/ext/language_tools");
        editor.setOptions({
            enableBasicAutocompletion: true,
            enableSnippets: true
        });
    }
};

$(document).on('ready page:load', function () {
    configure_ace_editor();
});
