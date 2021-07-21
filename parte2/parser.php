<?php
$file = "repositorio.xml";
$map_array = array(
    "CURSO" => "hr",
    "TITULO" => "li",
    "NIVEL" => "li",
    "LISTATEMAS" => "li",
    "TEMA" => "hr",
    "LISTARECURSOS" => "li",
    "RECURSO" => "hr",
    "VIDEO" => "li",
    "FORMATO" => "li",
    "DURACION" => "li",
    "URI" => "li",
    "LISTAEJERCICIOS" => "li",
    "EJERCICIO" => "li",
    "ENUNCIADO" => "li",
    "SOLUCION" => "ol",
    "VALOR" => "li",
    "DESARROLLO" => "li",
); 
//al encontrar etiqueta de inicio
function startTag($parser, $name, $attrs)
{
    global $map_array;
    if (isset($map_array[$name])) {
        echo "<$map_array[$name]>";
        echo "$name:";
        //atributos
        foreach ($attrs as $key => $value) {
            echo "($key=$value)";
        }
    }
    
}
//al encontrar etiqueta de fin
function endTag($parser, $name)
{
    global $map_array;
    if (isset($map_array[$name])) {
        echo "</$map_array[$name]>";
    }
}

function characterData($parser, $data)
{
    echo "$data";
}

//main
$xml_parser = xml_parser_create();
//use case-folding os we are sure to find the tag in $map_array
xml_parser_set_option($xml_parser, XML_OPTION_CASE_FOLDING, true);
xml_set_element_handler($xml_parser, "startTag", "endTag");
xml_set_character_data_handler($xml_parser, "characterData");
if (!($fp = fopen($file, "r"))) {
    die("could not open XML input");
}

echo "<html><head><title>Repositorio</title></head><body>";
while ($data = fread($fp, 4096)) {
    if (!xml_parse($xml_parser, $data, feof($fp))) {
        die(sprintf("XML error: %s at line %d",
                    xml_error_string(xml_get_error_code($xml_parser)),
                    xml_get_current_line_number($xml_parser)));
    }
}
echo "</body></html>";
xml_parser_free($xml_parser);
?>