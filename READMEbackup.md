# template



**template for pathology atlas repositories**



```
see [make-html-WSI](https://github.com/pathologyatlas/make-html-WSI) for more information and [TODO](https://github.com/pathologyatlas/TODO) to add cases
```

```
update html files:

<title>TemplateEN templateTR</title>

<meta name="keywords" content="TemplateEN, templateTR, patoloji, atlas, pathology, whole slide image">

<meta name="description" content="TemplateEN templateTR">

```


> after upload complete, do not forget to activate github pages for the new repository




```zsh

vips dzsave HE.svs HE

```




```{r language template, echo=FALSE, include=TRUE}

source("./R/language.R")

```




```{asis, echo = (language == "TR")}

## TemplateTR {#sec-template}

```




```{asis, echo = (language == "EN")}

## TemplateEN {#sec-template}

```

```{r, eval=TRUE, include=FALSE}
if (!file.exists("./screenshots/template_screenshot.png")) {
webshot2::webshot(
  url = "https://images.patolojiatlasi.com/template/HE.html",
  file = "./screenshots/template_screenshot.png"
)
}


```


```{asis, echo = (language == "TR")}

**templateTR**


[![Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/template_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/template/HE.html) [Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/template/HE.html)

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



{{< video https://www.youtube.com/embed/ >}}



```



```{asis, echo = (language == "EN")}

**templateEN**

[![Click for Full Screen WSI](./screenshots/template_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/template/HE.html) [Click for Full Screen WSI](https://images.patolojiatlasi.com/template/HE.html)

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


{{< video https://www.youtube.com/embed/ >}}



```
