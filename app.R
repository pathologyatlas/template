# Import shiny library
library(shiny)
library(whisker)

source("./generate_qmd.R")
source("./generate_html.R")

# UI definition
ui <- fluidPage(
  # Include ShinyJS for running JavaScript
  shinyjs::useShinyjs(),

  # Include custom JavaScript for text selection
  tags$head(
    tags$script(HTML("
            function selectText(elementId) {
                var container = document.getElementById(elementId);
                if (container) {
                    var textElement = container.getElementsByTagName('pre')[0];
                    if (textElement) {
                        var range = document.createRange();
                        range.selectNodeContents(textElement);
                        var sel = window.getSelection();
                        sel.removeAllRanges();
                        sel.addRange(range);
                    }
                }
            }
        "))
  ),

  titlePanel("Template Generator - Generate .qmd File"),

  sidebarLayout(
    sidebarPanel(
      checkboxInput("base_template", "Base Template", value = TRUE),
      textInput("TemplateTR", "Enter TemplateTR", value = "TemplateTR"),
      textInput("TemplateEN", "Enter TemplateEN", value = "TemplateEN"),
      textInput("template", "Enter template", value = "template"),
      textAreaInput("stain", "Enter stain (comma separated)", value = "HE1, HE2"),
      checkboxInput("diagnosis", "Diagnosis", value = TRUE),
      checkboxInput("use_youtube", "Use YouTube", value = FALSE),
      textInput("youtube_link", "YouTube Link", value = "youtube_link"),
      checkboxInput("end_template", "End Template", value = FALSE),
      actionButton("generate", "Generate Code"),
      br(),
      downloadButton('downloadFile_qmd', 'Download qmd file'),
      br(),
      downloadButton('downloadFile_readme', 'Download readme file'),
      br(),
      downloadButton('downloadFile_html', 'Download html file')
    ),
    mainPanel(
      h4("QMD Text:"),
      actionButton("select_qmd", "Select QMD Text"),
      div(id = "qmdtext-container", verbatimTextOutput("qmdtext")),
      h4("README Text:"),
      actionButton("select_readme", "Select README Text"),
      div(id = "readmetext-container", verbatimTextOutput("readmetext")),
      h4("html Text:"),
      actionButton("select_html", "Select html Text"),
      div(id = "htmltext-container", verbatimTextOutput("htmltext")),
      textOutput("fileWriteStatus")
    )
  )

  )


# Server function definition
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
      youtube_link = input$youtube_link,
      end_template = input$end_template
    )
  })

  output$readmetext <- renderText({
    req(readme_data())
    readme_data()
  })


  html_data <- eventReactive(input$generate, {
    stain <- strsplit(input$stain, ",")[[1]]
    stain <- trimws(stain)

    html_text(
      # base_template = input$base_template,
      TemplateTR = input$TemplateTR,
      TemplateEN = input$TemplateEN,
      # template = input$template,
      stain = stain,
      # diagnosis = input$diagnosis,
      # use_youtube = input$use_youtube,
      # youtube_link = input$youtube_link,
      # end_template = input$end_template
    )
  })

  output$htmltext <- renderText({
    req(html_data())
    html_data()
  })



  output$downloadFile_qmd <- downloadHandler(
    filename = function() {
      paste0("_", input$template, ".qmd")
    },
      content = function(file) {
        writeLines(qmd_data(), file)
      },
      contentType = "text/qmd"
    )
  observeEvent(input$generate, {
    output$fileWriteStatus <- renderText("File written successfully.")
  })


  output$downloadFile_readme <- downloadHandler(
    filename = function() {
      paste0("README.md")
    },
    content = function(file) {
      writeLines(readme_data(), file)
    },
    contentType = "text/markdown"
  )

  output$downloadFile_html <- downloadHandler(
    filename = function() {
      paste0("htmltext.html")
    },
    content = function(file) {
      writeLines(html_data(), file)
    },
    contentType = "text/markdown"
  )



  # JavaScript actions for the selection buttons
  observeEvent(input$select_qmd, {
    shinyjs::runjs('selectText("qmdtext-container")')
  })

  observeEvent(input$select_readme, {
    shinyjs::runjs('selectText("readmetext-container")')
  })
  observeEvent(input$select_html, {
    shinyjs::runjs('selectText("htmltext-container")')
  })



}

# Run the Shiny app
shinyApp(ui, server)
