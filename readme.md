#A boiler plate environment to start XSLT projects

This is a template to use as a starting point for XSLT related projects.

Many of the XSLT and XML related build tools I use are maintained in my
[ant-hology](http://github.com/darcyparker/ant-hology) github repo.

Some useful XSLT templates and functions are included in the [./xsl](./xsl)
directory. Some of these are included/managed in this repo, while others
can be downloaded using the ant script [./xsl/build-getXSL.xml](./xsl/build-getXSL.xml).

> Example usage: `ant -f build-getXSL.xml getXSL`

> *Note:*
> Most of the character maps come from [www.w3c.org](http://www.w3c.org) and may
> include some minor formatting edits to improve readability. Generally I'd like
> to download these using the [./xsl/build-getXSL.xml](./xsl/build-getXSL.xml)
> script, but I have found it difficult to locate reliable URLs so I am including
> them in this repo for convenience.
