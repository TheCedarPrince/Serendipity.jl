using PDFIO

"""
```
    getPDFText(src, out) -> Dict 
```

- src - Input PDF file path from where text is to be extracted
- out - Output TXT file path where the output will be written
return - A dictionary containing metadata of the document
"""
function getPDFText(src, out)
    # handle that can be used for subsequence operations on the document.
    doc = pdDocOpen(src)
    
    # Metadata extracted from the PDF document. 
    # This value is retained and returned as the return from the function. 
    docinfo = pdDocGetInfo(doc) 
    open(out, "w") do io
    
        # Returns number of pages in the document       
        npage = pdDocGetPageCount(doc)

        for i=1:npage
        
            # handle to the specific page given the number index. 
            page = pdDocGetPage(doc, i)
            
            # Extract text from the page and write it to the output file.
            pdPageExtractText(io, page)

        end
    end
    # Close the document handle. 
    # The doc handle should not be used after this call
    pdDocClose(doc)
    return docinfo
end

getPDFText("tmp/1.pdf", "pdfio_test.txt")

txt = read("pdfio_test.txt", String) |> split_sentences

open("pdfio_test.txt", "w") do f
    for sentence in txt
	write(f, sentence * "\n")
    end
end

