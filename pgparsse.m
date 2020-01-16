BeginPackage["pgparsse`"]
Unprotect @@ Names["pgparsse`*"];
ClearAll @@ Names["pgparsse`*"];

ParsePGPass::usage = "Parse .pgpass"

Begin["`Private`"]

pgpassFile[path_] := Import[path];

pgpassFormattedFile[path_] := If[
    ListQ[pgpassFile[path]],
    pgpassFile[path],
    {{pgpassFile[path]}}
];

pgpassParsedFile[path_] := Map[
    StringSplit[#, ":"][[1]] &,
    pgpassFormattedFile[path]
];

parseLine[l_] := <|
    "JDBC String" ->
        "jdbc:postgresql://" <> l[[1]] <> ":" <> l[[2]] <> "/" <> l[[3]],
    "Username" -> l[[4]], "Password" -> l[[5]]|>;

ParsePGPass[path_ : "~/.pgpass"] := Map[parseLine, pgpassParsedFile[path]];

End[]
Protect @@ Names["pgparsse`*"];
EndPackage[]
