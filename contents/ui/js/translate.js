function translateText(text, sourceLang, targetLang, callback) {
    // Construir la URL con los parámetros necesarios
    const baseUrl = "https://api.mymemory.translated.net/get";
    const langpair = `${sourceLang}|${targetLang}`;
    const url = `${baseUrl}?q=${encodeURIComponent(text)}&langpair=${encodeURIComponent(langpair)}`;

    // Crear una nueva instancia de XMLHttpRequest
    const xhr = new XMLHttpRequest();
    xhr.open("GET", url, true);

    // Definir qué hacer cuando la solicitud se complete
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) { // Solicitud completada
            if (xhr.status === 200) { // Respuesta exitosa
                try {
                    const response = JSON.parse(xhr.responseText);
                    // La traducción se encuentra en response.responseData.translatedText
                    callback(null, response.responseData.translatedText);
                } catch (e) {
                    callback(new Error("Error al parsear la respuesta JSON"), null);
                }
            } else {
                callback(new Error(`Error: ${xhr.status}`), null); // Manejar errores
            }
        }
    };

    // Enviar la solicitud
    xhr.send();
}
