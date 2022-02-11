import qualified Test.Tasty as Tasty
import qualified Test.Tasty.HUnit as HUnit
import qualified MinJs as MinJs
import qualified Data.Text.Encoding as Encoding
import qualified Data.ByteString as B


main :: IO ()
main =
    Tasty.defaultMain $
    Tasty.testGroup "compiler"
    [ HUnit.testCase "hello world" $
        MinJs.minjs helloWorld HUnit.@?= Nothing
    ]


helloWorld :: B.ByteString
helloWorld =
    Encoding.encodeUtf8
    "<!DOCTYPE html>\n\
    \<html lang='en-GB'>\n\
    \<head>\n\
    \<meta charset=\"utf-8\">\n\
    \<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n\
    \</head>\n\
    \<body></body>\n\
    \<script>\n\
    \function update(msg, model) {\n\
    \    switch (msg.k) {\n\
    \    case \"start\":\n\
    \        return\n\
    \            [ model\n\
    \            , { k: 'wait'\n\
    \              , v:\n\
    \                  { delay: 5000\n\
    \                  , cmd: {k: \"alert\", v: \"hello world!\"}\n\
    \                  }\n\
    \               }\n\
    \            ];\n\
    \    }\n\
    \}\n\
    \\n\
    \\n\
    \{\n\
    \    let model;\n\
    \    let cmd;\n\
    \\n\
    \\n\
    \    function tick(cmd) {\n\
    \        [model, cmd] = update({k: \"start\"}, model);\n\
    \        switch (cmd.k) {\n\
    \        case \"wait\":\n\
    \            setTimeout(tick(cmd.v.cmd), cmd.v.delay);\n\
    \            return;\n\
    \        }\n\
    \    }\n\
    \}\n\
    \</script>\n\
    \</html>\n\
    \"
