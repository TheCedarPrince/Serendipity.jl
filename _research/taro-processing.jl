using Taro
using WordTokenizers

txt = Taro.extract("tmp/1.pdf")[2] |> split_sentences

open("taro_test.txt", "w") do f
    for sentence in txt
        write(f, sentence * "\n")
    end
end

