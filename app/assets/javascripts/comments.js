$(document).ready(function(){

    $('#create_comment_form')
        .bind("ajax:beforeSend", function(evt, xhr, settings){
            var $submitButton = $(this).find('input[name="commit"]');

            $submitButton.data( 'origText', $(this).text() );
            $submitButton.text( "Submitting..." );

        })
        .bind("ajax:success", function(evt, data, status, xhr){
            var $form = $(this);

            $form.find('textarea,input[type="text"],input[type="file"]').val("");
            $form.find('div.validation-error').empty();

            $('#comments').append(xhr.responseText);

        })
        .bind('ajax:complete', function(evt, xhr, status){
            var $submitButton = $(this).find('input[name="commit"]');

            $submitButton.text( $(this).data('origText') );
        })
        .bind("ajax:error", function(evt, xhr, status, error){
            var $form = $(this),
                errors,
                errorText;

            try {
                errors = $.parseJSON(xhr.responseText);
            } catch(err) {
                errors = {message: "Please reload the page and try again"};
            }

            errorText = "There were errors with the submission: \n<ul>";

            for ( error in errors ) {
                errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
            }

            errorText += "</ul>";

            $form.find('div.validation-error').html(errorText);
        });

});