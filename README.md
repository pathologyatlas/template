# template



**template for pathology atlas repositories**




> see [make-html-WSI](https://github.com/pathologyatlas/make-html-WSI) for more information and [TODO](https://github.com/pathologyatlas/TODO) to add cases




> do not forget to activate github pages for the new repository




```zsh

vips dzsave HE.svs HE

```




```{r language template, echo=FALSE, include=TRUE}

source("./R/language.R")

```




```{asis, echo = (language == "TR")}

## TemplateTR

```




```{asis, echo = (language == "EN")}

## TemplateEN

```




```{asis, echo = (language == "TR")}

**templateTR**


[https://images.patolojiatlasi.com/template/HE.html](https://images.patolojiatlasi.com/template/HE.html)

Mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/template/HE.html" style="height:400px;width:100%;" data-external="1"></iframe>

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


[https://images.patolojiatlasi.com/template/HE.html](https://images.patolojiatlasi.com/template/HE.html)

See Microscopy with viewer: 

<iframe src="https://images.patolojiatlasi.com/template/HE.html" style="height:400px;width:100%;" data-external="1"></iframe>

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
