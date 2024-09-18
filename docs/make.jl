using ShaneDBSCAN
using Documenter

DocMeta.setdocmeta!(ShaneDBSCAN, :DocTestSetup, :(using ShaneDBSCAN); recursive=true)

makedocs(;
    modules=[ShaneDBSCAN],
    authors="Shane Kuei-Hsien Chu (skchu@wustl.edu)",
    sitename="ShaneDBSCAN.jl",
    format=Documenter.HTML(;
        canonical="https://kchu25.github.io/ShaneDBSCAN.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/kchu25/ShaneDBSCAN.jl",
    devbranch="main",
)
