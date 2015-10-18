class window.Game
  contructor: ->
    @chooseOption()

  chooseOption: =>
    $("#game_form").delegate "input[type=radio]", "click", ->
      option_value = $('#choose_team input[type=radio]:checked').val()
      if option_value == "list"
        $(".old-teams").removeClass("hidden")
        $(".new-team").addClass("hidden")
        $("#old_list_team").attr("value", true)
      else
        $(".old-teams").addClass("hidden")
        $(".new-team").removeClass("hidden")
        $("#old_list_team").attr("value", false)
