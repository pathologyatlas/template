# template

template for pathology atlas repositories

> see [make-html-WSI](https://github.com/pathologyatlas/make-html-WSI) for more information and [TODO](https://github.com/pathologyatlas/TODO) to add cases


> do not forget to activate github pages for the new repository


```zsh
vips dzsave HE.svs HE
```


```{r template, include=FALSE}
# language <- "EN"
# language <- "TR"
```


```{asis, echo = language == "TR"}

## templateTR

[https://pathologyatlas.github.io/template/HE.html](https://pathologyatlas.github.io/template/HE.html)

Mikroskopik görüntüleri inceleyin:

<iframe src="https://pathologyatlas.github.io/template/HE.html" style="height:400px;width:100%;"></iframe>

```


```{asis, echo = language == "EN"}

## templateEN

[https://pathologyatlas.github.io/template/HE.html](https://pathologyatlas.github.io/template/HE.html)

See Microscopy with viewer: 

<iframe src="https://pathologyatlas.github.io/template/HE.html" style="height:400px;width:100%;"></iframe>

```

