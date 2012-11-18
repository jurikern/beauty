jQuery ->
  $('#delete_company_logo').click ->
    $(@).parent().remove()
    $('#company_logo_cache, #company_remote_logo_url, #company_logo_cover').val(null)

  $('#company_logo_cover, #company_logo_cover_btn').click ->
    $('input[id=company_logo]').click();

  $('input[id=company_logo]').change ->
    $('#company_logo_cover').val($(@).val())