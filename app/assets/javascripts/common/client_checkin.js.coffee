class ClientCheckin
  constructor: ->
    @phoneFormat()
    @applyFormValidate()
    @checkPets()
    @dateFormat()


  phoneFormat: ->
    $('#client_checkin_phone').on 'input', (e) ->
      x = e.target.value.replace(/\D/g, '').match(/(\d{0,3})(\d{0,3})(\d{0,4})/)
      e.target.value = if !x[2] then x[1] else '(' + x[1] + ') ' + x[2] + (if x[3] then '-' + x[3] else '')
      return

  applyFormValidate: ->
    $('#client_apply_form').validate({
      rules:
        dob:
          rangelength: [10,10]
        qpets:
          required: true
        type:
          required: true
        startdate:
          rangelength: [10,10]
      messages:
        dob:
          rangelength: "Enter valid date"
        startdate:
          rangelength: "Enter valid date"
    })

  checkPets: ->
    $('input[name="qpets"]').change ->
      check_val = $('input[name="qpets"]:checked').val()
      if check_val == "Yes"
        $('#pet-fields').show()
      else if check_val == "No"
        $('#pet-fields').hide()

  dateFormat: ->
    $('.date-format').on 'input', (e) ->
      x = e.target.value.replace(/\D/g, '').match(/(\d{0,2})(\d{0,2})(\d{0,4})/)
      e.target.value = if !x[2] then x[1] else x[1] + '/' + x[2] + (if x[3] then '/' + x[3] else '')
      return


  @setup: ->
    new ClientCheckin

App.ClientCheckin = ClientCheckin.setup
