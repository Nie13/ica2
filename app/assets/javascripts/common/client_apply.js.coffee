class ClientApply
  constructor: ->
    @applyFormValidate()
    @prevForm()
    @checkPets()
    @dateFormat()
    @formselectValue()
    @documentForm()
    #@visaOption()
    @optOption()
    @docShow()
    @fancyboxDocs()


  applyFormValidate: ->
    $('#next-btn').click (e)->
      form = $('#client_apply_form')
      form.validate({
        rules:
          'client_apply[email]':
            email: true
          'client_apply[dob]':
            date: true
          qpets:
            required: true
          'client_apply[start_date]':
            date: true
          'client_apply[referral]':
            required: true
          'client_apply[status][]':
            required: true
        messages:
          'client_apply[dob]':
            date: "Enter valid date"
          'client_apply[start_date]':
            date: "Enter valid date"
          'client_apply[status][]':
            required: "You must check atleast 1 box"
        errorPlacement:(error, element) ->
          if element.attr('name') == 'client_apply[status][]'
            error.appendTo($('.options').last())
          else
            error.insertAfter element
      })
      if(form.valid() == true)
        check_val = $('input[name="client_apply[residency]"]:checked').length
        curr_step = $('#client-fields')
        next_step = $('#resident-option')
        next_step.show()
        $('.resident-info').show()
        curr_step.hide()
        if check_val > 0
          $('#docu-fields').show()
          showDocPages()
        $('#work-option').hide()

  prevForm: ->
    $('#back-btn').click ->
      curr_step = $('#docu-fields')
      next_step = $('#client-fields')
      next_step.show()
      curr_step.hide()
      $('#resident-option').hide()
      $('.resident-info').hide()
      $('#form-submit').hide()
      $('#work-option').show()

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

  formselectValue: ->
    $('input[name="client_apply[is_employed]"]').change ->
      check_val = $('input[name="client_apply[is_employed]"]:checked').val()
      if check_val == "true"
        $('#client-fields').hide()
        $('#school-field').hide()
        $('#company-field').show()
        $('#client_apply_position').val("")
      else if check_val == "false"
        $('#client-fields').hide()
        $('#company-field').hide()
        $('#school-field').show()
        $('#client_apply_position').val("Student")
      $('#client-fields').show("fade")

  documentForm: ->
    $('input[name="client_apply[residency]"]').change ->
      showDocPages()

  showDocPages = ->
    value = $('input[name="client_apply[residency]"]:checked').val()
    check_val = $('input[name="client_apply[is_employed]"]:checked').val()
    if value == "international"
      if check_val == "true"
        $('#int-student-docs').hide()
        $('#local-student-docs').hide()
        $('#local-employed-docs').hide()
        $('#int-employed-docs').show()
        $('#opt-option').show("fade")
      else if check_val == "false"
        $('#local-student-docs').hide()
        $('#local-employed-docs').hide()
        $('#int-employed-docs').hide()
        $('#int-student-docs').show()
        #$('#visa-option').show("fade")
    else if value == "local"
      if check_val == "true"
        $('#local-student-docs').hide()
        $('#int-employed-docs').hide()
        $('#int-student-docs').hide()
        $('#local-employed-docs').show("fade")
      else if check_val == "false"
        $('#int-employed-docs').hide()
        $('#local-employed-docs').hide()
        $('#int-student-docs').hide()
        $('#local-student-docs').show("fade")
    $('p.doc-msg').show()
    $('#form-submit').show()

  #visaOption: ->
  #  $('input[name="immigration"]').change ->
  #    displayfieldsIm()

  optOption: ->
    $('input[name="workvisa"]').change ->
      displayfieldsOpt()

  #displayfieldsIm = ->
  #  value = $('input[name="immigration"]:checked').val()
  #  if value == "true"
  #    $('.int-visa').hide()
  #    $('.int-green').show()
  #    $('#int-student-fields').show("fade")
  #  else if value == "false"
  #    $('.int-green').hide()
  #    $('.int-visa').show()
  #    $('#int-student-fields').show("fade")

  displayfieldsOpt = ->
    value = $('input[name="workvisa"]:checked').val()
    if value == "true"
      $('.int-h1b').hide()
      $('.int-opt').show()
      $('#int-employed-fields').show("fade")
    else if value == "false"
      $('.int-opt').hide()
      $('.int-h1b').show()
      $('#int-employed-fields').show("fade")

  docShow: ->
    $('input[type="file"]').change ->
      input = this
      parent = $(this).parents('.form-group')
      parent.find('.new-file').remove()
      if input.files && input.files[0]

        files = input.files
        i=0
        while i<files.length
          type = input.files[i].type
          readAndPreview(input.files[i],parent,type)
          i++
  readAndPreview = (file, parent, filetype) ->
    reader = new FileReader
    reader.addEventListener 'load', (->
      if filetype == "application/pdf"
        elem = $('<a></a>').text(file.name)
          .attr('href': this.result)
          .attr('data-fancybox-type': 'iframe')
          .addClass('fancypdf new-file')
          #.addClass('fancybox.iframe')
        parent.append(elem)
      else
        elem = $('<a></a>').text(file.name)
          .attr('href': this.result)
          .addClass('fancybox new-file')
        parent.append(elem)
    ), false

    reader.readAsDataURL(file)

  fancyboxDocs: ->
    $('.fancypdf').fancybox
      openEffect  : 'none',
      closeEffect : 'none',
      type: 'iframe'
      #iframe :
      #preload: false

    $('.fancybox').fancybox
      autoScale: false,
      type: 'iframe'
      #beforeLoad: ->
      #  url = $(this.element).data("href")
      #  console.log "hello"
      #  console.log url
      #  this.href = url

  @setup: ->
    new ClientApply

#******** Edit ClientApply page *******#

class ClientApplyEdit

  constructor: ->
    @docsClasses()
    @showhiddenDocs()

  docsClasses: ->
    $('.editlink').each ->
      type = $(this).attr('href').split(".").pop()
      if type == "pdf"
        $(this).addClass("fancypdf")
        $(this).attr('data-fancybox-type': 'iframe')
      else
        $(this).addClass("fancybox")

  showhiddenDocs: ->
    if ($('#int-employed-fields').length > 0)
      $('#int-employed-fields').show()

  @setup: ->
    new ClientApplyEdit

#***** Admin ClientApply ******#

class ClientApplyAdmin
  doc_ids = []

  constructor: ->
    @addClientid()

  addClientid: ->
    $('.add-doc').click ->
      doc_ids.push($(this).data('id'))
      $('#mail_build_client_docs_').val(doc_ids)
      $(this).attr("disabled", true)

  @setup: ->
    new ClientApplyAdmin

App.ClientApply = ClientApply.setup
App.ClientApplyEdit = ClientApplyEdit.setup
App.ClientApplyAdmin = ClientApplyAdmin.setup
