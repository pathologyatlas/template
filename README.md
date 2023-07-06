# template



**template for pathology atlas repositories**


```
see [make-html-WSI](https://github.com/pathologyatlas/make-html-WSI) for more information and [TODO](https://github.com/pathologyatlas/TODO) to add cases
```

```
In this README file replace the following:
TemplateEN with description of file in English
TemplateTR with description of file in Turkish
template with repository name

```


```
update html file <head>

<title>TemplateEN templateTR</title>

<meta name="keywords" content="TemplateEN, templateTR, patoloji, atlas, pathology, whole slide image">

<meta name="description" content="TemplateEN templateTR">

```



```zsh

vips dzsave HE.svs HE

```



```
update html file to match .dzi file

```


```
add to begining of qmd page

---
description: |
    TemplateEN
    TemplateTR
date: last-modified
categories: [template]
page-layout: full
bibliography: references.bib
---

```



> consider using git_push.sh script to upload files to github, since the number of generated files is huge

> after upload complete, do not forget to activate github pages for the new repository



```{r language template, echo=FALSE, include=TRUE}
source("./R/language.R")
output_type <- knitr::opts_knit$get("rmarkdown.pandoc.to")
```




```{asis, echo = (language == "TR")}
## TemplateTR {#sec-template}
```


```{asis, echo = (language == "EN")}
## TemplateEN {#sec-template}
```


```{r template screenshot, eval=TRUE, include=FALSE}
if (!file.exists("./screenshots/template_screenshot.png")) {
webshot2::webshot(
  url = "https://images.patolojiatlasi.com/template/HE.html",
  file = "./screenshots/template_screenshot.png"
)
}
```

```{r, echo=FALSE, include=FALSE, eval=FALSE}
knitr::include_url(url = "https://images.patolojiatlasi.com/template/HE.html")
```

```{r, echo=FALSE, include=FALSE, eval=FALSE}
#| label: template_screenshot
#| fig-cap: "TemplateTR"
knitr::include_graphics("./screenshots/template_screenshot.png")
```


::: {.content-hidden when-format="html"}
TemplateTR
:::

::: {.content-visible when-format="pdf"}
TemplateTR
:::



```{asis, echo = (language == "TR")}

**templateTR**


[![Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/template_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/template/HE.html) [Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/template/HE.html)
```


```{asis, echo = ((language=="TR") & (output_type=="html"))}
Mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/template/HE.html" style="height:600px;width:100%;" data-external="1"></iframe>

```



```{comment} 
asis, echo = (language == "TR")

**templateTR**


[![İşaretlenmiş mikroskopik görüntüleri Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/template_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/template/HE_annotated.html) [İşaretlenmiş mikroskopik görüntüleri Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/template/HE_annotated.html)

İşaretlenmiş mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/template/HE_annotated.html" style="height:600px;width:100%;" data-external="1"></iframe>

```



```{comment}
asis, echo = (language == "TR")



<button id="tani-case-template-btn">Tanıyı Göster</button>
<div id="answer-template" style="display: none;">templateTR</div>

<script>
  const showAnswer-templateBtn = document.getElementById('tani-case-template-btn');
  const answer-template = document.getElementById('answer-template');

  showAnswer-templateBtn.addEventListener('click', () => {
    if (answer-template.style.display === 'none') {
      answer-template.style.display = 'block';
      showAnswer-templateBtn.textContent = 'Tanıyı Gizle';
    } else {
      answer-template.style.display = 'none';
      showAnswer-templateBtn.textContent = 'Tanıyı Göster';
    }
  });
</script>

```

```{comment}
asis, echo = ((language=="TR") & (output_type=="html"))

{{< video https://www.youtube.com/embed/ >}}

```

```{comment}
asis, echo = ((language=="TR") & (output_type!="html"))

[https://www.youtube.com/watch?v=](https://www.youtube.com/watch?v=)

```





```{asis, echo = (language == "EN")}

**templateEN**

[![Click for Full Screen WSI](./screenshots/template_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/template/HE.html) [Click for Full Screen WSI](https://images.patolojiatlasi.com/template/HE.html)


```



```{asis, echo = ((language == "EN") & (output_type=="html"))} 

See Microscopy with viewer: 

<iframe src="https://images.patolojiatlasi.com/template/HE.html" style="height:600px;width:100%;" data-external="1"></iframe>

```


```{comment}
asis, echo = (language == "EN")

**templateEN**

[![Click for Full Screen Annotated WSI](./screenshots/template_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/template/HE_annotated.html) [Click for Full Screen Annotated WSI](https://images.patolojiatlasi.com/template/HE_annotated.html)


See Annotated Microscopy with viewer: 

<iframe src="https://images.patolojiatlasi.com/template/HE_annotated.html" style="height:600px;width:100%;" data-external="1"></iframe>



```

```{comment}
asis, echo = (language == "EN")

<button id="dx-case-template-btn">Show the Diagnosis</button>
<div id="answer-template" style="display: none;">templateEN</div>

<script>
  const showAnswer-templateBtn = document.getElementById('dx-case-template-btn');
  const answer-template = document.getElementById('answer-template');

  showAnswer-templateBtn.addEventListener('click', () => {
    if (answer-template.style.display === 'none') {
      answer-template.style.display = 'block';
      showAnswer-templateBtn.textContent = 'Hide the Diagnosis';
    } else {
      answer-template.style.display = 'none';
      showAnswer-templateBtn.textContent = 'Show the Diagnosis';
    }
  });
</script>

```


```{comment}
r, eval=TRUE, echo=FALSE, include=FALSE, error=TRUE
if (!file.exists("./screenshots/template_screenshot.png")) {

url <- "https://img.youtube.com/vi/U9glkfQLTm4/maxresdefault.jpg"
download.file(url, destfile = "./screenshots/template_screenshot.png", mode = "wb")
}

**TemplateTR**

[![Video İçin Tıklayın](./screenshots/template_screenshot.png){width="25%"}](https://www.youtube.com/watch?v=) [Video İçin Tıklayın](https://www.youtube.com/watch?v=)

```




```{comment}
asis, echo = ((language=="EN") & (output_type=="html"))

{{< video https://www.youtube.com/embed/ >}}

```

```{comment}
asis, echo = ((language=="EN") & (output_type!="html"))

[https://www.youtube.com/watch?v=](https://www.youtube.com/watch?v=)

```


```{comment}
=html
<iframe src="https://images.patolojiatlasi.com/template/HE.html" style="height:600px;width:100%;" data-external="1"></iframe>
```
