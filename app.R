# Import shiny library
library(shiny)
library(whisker)

source("./generate_qmd.R")

ui <- fluidPage(
  titlePanel("Template Generator - Generate .qmd File"),

  sidebarLayout(
    sidebarPanel(
      checkboxInput("base_template", "Base Template", value = FALSE),
      textInput("TemplateTR", "Enter TemplateTR", value = "TemplateTR"),
      textInput("TemplateEN", "Enter TemplateEN", value = "TemplateEN"),
      textInput("template", "Enter template", value = "template"),
      textAreaInput("stain", "Enter stain (comma separated)", value = "HE1, HE2"),
      checkboxInput("diagnosis", "Diagnosis", value = FALSE),
      checkboxInput("use_youtube", "Use YouTube", value = FALSE),
      textInput("youtube_link", "YouTube Link", value = "youtube_link"),
      actionButton("generate", "Generate qmd"),
      downloadButton('downloadFile', 'Download newfile.qmd')
    ),

    mainPanel(
      verbatimTextOutput("qmdtext"),
      verbatimTextOutput("readmetext"),
      textOutput("fileWriteStatus")
    )
  )
)

server <- function(input, output) {
  qmd_data <- eventReactive(input$generate, {
    stain <- strsplit(input$stain, ",")[[1]]
    stain <- trimws(stain)

    qmd_text(
      base_template = input$base_template,
      TemplateTR = input$TemplateTR,
      TemplateEN = input$TemplateEN,
      template = input$template,
      stain = stain,
      diagnosis = input$diagnosis,
      use_youtube = input$use_youtube,
      youtube_link = input$youtube_link
    )
  })

  output$qmdtext <- renderText({
    req(qmd_data())
    qmd_data()
  })

  readme_data <- eventReactive(input$generate, {
    stain <- strsplit(input$stain, ",")[[1]]
    stain <- trimws(stain)

    readme_text(
      base_template = input$base_template,
      TemplateTR = input$TemplateTR,
      TemplateEN = input$TemplateEN,
      template = input$template,
      stain = stain,
      diagnosis = input$diagnosis,
      use_youtube = input$use_youtube,
      youtube_link = input$youtube_link
    )
  })


  output$readmetext <- renderText({
    req(readme_data())
    readme_data()
  })



  output$downloadFile <- downloadHandler(
    filename = function() {
      paste("output", ".qmd", sep = "")
    },
    content = function(file) {
      writeLines(qmd_data(), file)
    },
    contentType = "text/qmd"
  )

  observeEvent(input$generate, {
    output$fileWriteStatus <- renderText("File written successfully.")
  })
}

shinyApp(ui, server)
