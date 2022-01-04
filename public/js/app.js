$(() => {
   $('#submit').on('click', (e) => {
       e.preventDefault()
       var formData = { 'url' : $('input[name=url]').val() }
       $.ajax({
           type: 'POST',
           url: '/',
           data: formData
       }).done(function(data) {
        console.log(data)
            if(data) {
                $('#shortened_url').html(`<span>${data}</span>`)
            }
       })

   })
})