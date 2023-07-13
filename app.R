# Import shiny library
library(shiny)

source("./generate_qmd.R")

# Define UI
ui <- fluidPage(
  titlePanel("Template Generator"),

  sidebarLayout(
    sidebarPanel(
      textInput("TemplateTR", "Enter TemplateTR", value = "TemplateTR"),
      textInput("TemplateEN", "Enter TemplateEN", value = "TemplateEN"),
      textInput("template", "Enter template", value = "template"),
      textAreaInput("stain", "Enter stain (comma separated)", value = "HE1, HE2"),
      textInput("youtube_link", "Enter YouTube Link", value = NULL),
      actionButton("generate", "Generate"),
      downloadButton('downloadFile', 'Download newfile.qmd')
    ),

    mainPanel(
      verbatimTextOutput("qmdtext"),
      textOutput("fileWriteStatus")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$fileWriteStatus <- renderText("")

  observeEvent(input$generate, {
    output$qmdtext <- renderPrint({
      stain <- strsplit(input$stain, ",")[[1]]
      stain <- trimws(stain)
      qmdtext <- qmd_text_base(input$TemplateTR, input$TemplateEN, input$template, stain, input$youtube_link)
      writeLines(qmdtext, "./newfile.qmd")
      output$fileWriteStatus <- renderText("File written successfully.")
    })
  })

  output$downloadFile <- downloadHandler(
    filename = function() {
      "newfile.qmd"
    },
    content = function(file) {
      file.copy("./newfile.qmd", file)
    }
  )
}

# Run the application
shinyApp(ui = ui, server = server)
