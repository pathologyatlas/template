# Import shiny library
library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Template Generator"),

  sidebarLayout(
    sidebarPanel(
      textInput("TemplateTR", "Enter TemplateTR", value = "TemplateTR"),
      textInput("TemplateEN", "Enter TemplateEN", value = "TemplateEN"),
      textInput("template", "Enter template", value = "template"),
      textAreaInput("stain", "Enter stain (comma separated)", value = "HE1, HE2"),
      actionButton("generate", "Generate")
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
      qmdtext <- qmd_text_base(input$TemplateTR, input$TemplateEN, input$template, stain)
      writeLines(qmdtext, "./newfile.qmd")
      output$fileWriteStatus <- renderText("File written successfully.")
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)
