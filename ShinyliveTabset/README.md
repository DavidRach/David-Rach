Encountered unexpected behavior while working with a tabset containing a shinylive code chunk as one of it's tabs.

The regular R code-chunks for the tabset use "#\| title:" for naming, but this didn't work for the shinylive-R code chunk. It simply appeared as Tab 5 (in order appearance).

![](ShinyliveTabset/TabsetNames.png)

For a minimal reproducible example, see the index.qmd file within this folder, it contains the same formatting of the webpage plus the self-contained shinylive chunk.
