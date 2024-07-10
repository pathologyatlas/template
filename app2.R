# Import shiny library
library(shiny)
library(whisker)
library(XML)

source("./generate_qmd.R")
source("./generate_html.R")




# Default values
default_width <- "80000"
default_height <- "50000"

# Function to parse DZI files

parse_dzi <- function(dzi_path) {
  tryCatch({
    # Read the file content
    lines <- readLines(dzi_path, warn = FALSE)

    # Combine all lines into a single string
    content <- paste(lines, collapse = " ")

    # Use regex to extract width and height
    width <- regmatches(content, regexec('Width="([0-9]+)"', content))[[1]][2]
    height <- regmatches(content, regexec('Height="([0-9]+)"', content))[[1]][2]

    if (is.na(width) || is.na(height)) {
      stop("Width or Height not found in DZI file")
    }

    return(list(width = width, height = height))
  }, error = function(e) {
    warning(paste("Error parsing DZI file:", dzi_path, "-", e$message))
    return(list(width = default_width, height = default_height))
  })
}



# UI definition

ui <- fluidPage(
  shinyjs::useShinyjs(),

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

  titlePanel("Quarto Document Generator"),

  sidebarLayout(
    sidebarPanel(
      h4("Template Settings"),
      checkboxInput("base_template", "Include Base Template", value = TRUE),
      textInput("TemplateTR", "Turkish Template Name", value = "TemplateTR"),
      textInput("TemplateEN", "English Template Name", value = "TemplateEN"),
      textInput("template", "Main Template Name", value = "template"),

      h4("Stain Information"),
      textAreaInput("stain", "Stain Names (comma separated)", value = "HE1, HE2",
                    placeholder = "e.g., HE1, HE2, PAS"),
      fileInput("dzi_files", "Upload DZI Files (optional)", multiple = TRUE, accept = c(".dzi")),

      h4("Additional Options"),
      checkboxInput("diagnosis", "Include Diagnosis Section", value = TRUE),
      checkboxInput("use_youtube", "Include YouTube Video", value = FALSE),
      conditionalPanel(
        condition = "input.use_youtube == true",
        textInput("youtube_link", "YouTube Video Link")
      ),
      checkboxInput("end_template", "Include End Template", value = FALSE),

      actionButton("generate", "Generate Documents", class = "btn-primary")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Quarto Document",
                 h4("Generated Quarto (.qmd) Content:"),
                 div(style = "display: flex; gap: 10px;",
                     actionButton("select_qmd", "Select All Text"),
                     downloadButton('downloadFile_qmd', 'Download .qmd File')
                 ),
                 tags$div(id = "qmdtext-container", verbatimTextOutput("qmdtext"))
        ),
        tabPanel("README",
                 h4("Generated README Content:"),
                 div(style = "display: flex; gap: 10px;",
                     actionButton("select_readme", "Select All Text"),
                     downloadButton('downloadFile_readme', 'Download README File')
                 ),
                 tags$div(id = "readmetext-container", verbatimTextOutput("readmetext"))
        ),
        tabPanel("HTML",
                 h4("Generated HTML Content:"),
                 div(style = "display: flex; gap: 10px;",
                     actionButton("select_html", "Select All Text"),
                     uiOutput("download_buttons")
                 ),
                 tags$div(id = "htmltext-container", verbatimTextOutput("htmltext"))
        )
      ),
      textOutput("fileWriteStatus")
    )
  )
)




# Server logic
server <- function(input, output, session) {

  # Server logic
server <- function(input, output) {




  dzi_info <- reactive({
    req(input$dzi_files)
    dzi_paths <- input$dzi_files$datapath
    stains <- tools::file_path_sans_ext(input$dzi_files$name)
    stains <- sapply(stains, trimws)  # Apply trimws to each stain name individually

    print("DZI file paths:")
    print(dzi_paths)

    result <- list()
    for (i in seq_along(dzi_paths)) {
      info <- parse_dzi(dzi_paths[i])
      result[[stains[i]]] <- info
    }

    print("Parsed DZI info:")
    print(result)

    return(result)
  })




  html_data <- eventReactive(input$generate, {
    stains <- strsplit(input$stain, ",")[[1]]
    stains <- sapply(stains, trimws)  # Apply trimws to each stain name individually
    dzi_info_list <- dzi_info()

    # Print debugging information
    print("Stains:")
    print(stains)
    print("DZI info keys:")
    print(names(dzi_info_list))

    # If no DZI files were uploaded, create a default list
    if (length(dzi_info_list) == 0) {
      dzi_info_list <- lapply(stains, function(s) {
        list(width = default_width, height = default_height)
      })
      names(dzi_info_list) <- stains
    } else {
      # Ensure all stains have DZI info
      for (s in stains) {
        if (!(s %in% names(dzi_info_list))) {
          warning(paste("DZI info for stain", s, "is missing. Using default values."))
          dzi_info_list[[s]] <- list(width = default_width, height = default_height)
        }
      }
    }

    # Print final DZI info list
    print("Final DZI info list:")
    print(dzi_info_list)

    html_text(
      TemplateTR = input$TemplateTR,
      TemplateEN = input$TemplateEN,
      stain = stains,
      dzi_info = dzi_info_list
    )
  })



  output$html_output <- renderUI({
    html_list <- html_data()
    lapply(names(html_list), function(stain) {
      div(
        h3(stain),
        pre(html_list[[stain]])
      )
    })
  })
}



dzi_info <- reactive({
  if (is.null(input$dzi_files)) {
    return(list())
  }

  dzi_paths <- input$dzi_files$datapath
  stains <- tools::file_path_sans_ext(input$dzi_files$name)
  stains <- sapply(stains, trimws)  # Apply trimws to each stain name individually


  print("DZI file paths:")
  print(dzi_paths)

  result <- list()
  for (i in seq_along(dzi_paths)) {
    info <- parse_dzi(dzi_paths[i])
    result[[stains[i]]] <- info
  }

  print("Parsed DZI info:")
  print(result)

  return(result)
})

observeEvent(input$dzi_files, {
  stains <- tools::file_path_sans_ext(input$dzi_files$name)
  updateTextAreaInput(session, "stain", value = paste(stains, collapse = ", "))
})






  qmd_data <- eventReactive(input$generate, {
    qmd_text(
      base_template = input$base_template,
      TemplateTR = input$TemplateTR,
      TemplateEN = input$TemplateEN,
      template = input$template,
      stain = strsplit(input$stain, ",")[[1]],
      diagnosis = input$diagnosis,
      use_youtube = input$use_youtube,
      youtube_link = input$youtube_link
      # end_template = input$end_template
    )
  })

  output$qmdtext <- renderText({
    req(qmd_data())
    qmd_data()
  })

  readme_data <- eventReactive(input$generate, {
    stain <- strsplit(input$stain, ",")[[1]]
    stains <- sapply(stain, trimws)  # Apply trimws to each stain name individually
    readme_text(
      base_template = input$base_template,
      TemplateTR = input$TemplateTR,
      TemplateEN = input$TemplateEN,
      template = input$template,
      stain = strsplit(input$stain, ",")[[1]],
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
    stains <- strsplit(input$stain, ",")[[1]]
    stains <- sapply(stains, trimws)  # Apply trimws to each stain name individually
    dzi_info_list <- dzi_info()

    # Print debugging information
    print("Stains:")
    print(stains)
    print("DZI info keys:")
    print(names(dzi_info_list))

    # Use default values if dzi_info is missing for a stain
    for (s in stains) {
      if (is.null(dzi_info_list[[s]])) {
        warning(paste("DZI info for stain", s, "is missing. Using default values."))
        dzi_info_list[[s]] <- list(width = default_width, height = default_height)
      }
    }

    html_text(
      TemplateTR = input$TemplateTR,
      TemplateEN = input$TemplateEN,
      stain = stains,
      dzi_info = dzi_info_list
    )
  })


  output$htmltext <- renderText({
    req(html_data())
    paste(unlist(html_data()), collapse = "\n\n")
  })

  output$download_buttons <- renderUI({
    req(html_data())
    stains <- strsplit(input$stain, ",")[[1]]
    stains <- sapply(stains, trimws)  # Apply trimws to each stain name individually
    buttons <- lapply(stains, function(stain) {
      downloadButton(paste0('downloadFile_html_', stain), paste('Download ', stain, '.html'))
    })
    do.call(tagList, buttons)
  })

  observe({
    req(html_data())
    stains <- strsplit(input$stain, ",")[[1]]
    stains <- sapply(stains, trimws)  # Apply trimws to each stain name individually
    for (stain in stains) {
      local({
        s <- stain
        output[[paste0('downloadFile_html_', s)]] <- downloadHandler(
          filename = function() {
            paste0(s, ".html")
          },
          content = function(file) {
            writeLines(html_data()[[s]], file)
          },
          contentType = "text/html"
        )
      })
    }
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

  output$downloadFile_readme <- downloadHandler(
    filename = function() {
      paste0("README.md")
    },
    content = function(file) {
      writeLines(readme_data(), file)
    },
    contentType = "text/markdown"
  )

  observeEvent(input$generate, {
    output$fileWriteStatus <- renderText("Files written successfully.")
  })

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
