# Narzędzia do testowania kompilatorów języków *mini* i *mini++* (patrz: [zadania](./doc))

### Struktura testów

W plikach `tests.txt`, `tests_groupA.txt`, itp. znajdują się listy plików testowych.
	
Pliki źródłowe wymienione w np. `tests.txt` powinny znajdować się w folderze `tests`. Oczekiwane wyniki powinny znajdować się w `expected_results` i mieć dokładnie takie same nazwy jak pliki w `tests`. W katalogu `inputs` powinien znajdować się oczekiwany plik wejściowy, jeśli jest potrzebny.
	
W przypadku oczekiwanego błędu kompilacji, odpowiedni plik w folderze `expected_results` powinien zawierać tekst "error" – przykłady już istnieją.
	
### Jak testować
	
Do testowania służą pliki `.bat`. Uruchamiamy plik `test.bat` (z VS CMD, z folderu w którym znajduje się ten plik), dla którego pierwszym argumentem **musi** być ścieżka do pliku wykonywalnego naszego kompilatora języka *mini*.
	
Pliki te zapisują wyniki w folderze `results`. Komunikat "critical_error" w pliku informuje o błędzie na jednym z trzech etapów występujących po przejściu naszego kompilatora (asemblacja kodu CIL, weryfikacja programem peverify, wykonanie programu). Komunikat "compiler_error" mówi o ujemnym kodzie wyjścia z naszego kompilatora – najprawdopodobniej chodzi o wtedy o niewyłapany wyjątek. Należy zadbać, by w przypadku błędu kompilacji zwrócić wartość dodatnią.

Wyjścia z `results` porównywane są z odpowiadającymi im plikami w `expected_results`. Wszystkie znalezione różnice zapisywane są do pliku `errors.txt`. Jeśli zawiera on tylko linijkę "errors_detected" - oznacza to, że wszystko jest OK.

### Uwagi

Test `test_for5.bat`, oprócz testów z `tests_for5.txt` agreguje także wszystkie pozostałe grupy testów.
	
W samym kompilatorze nie może być wywołań metod `Console.ReadKey` ani `Console.ReadLine` – oczekiwanie na wejście od użytkownika jest zbędne i traktowane jako zawieszenie się kompilatora.

Osoby rozwijające swój kompilator na systemach Unixowych mogą skorzystać ze skryptu `test.sh` który jest Bashowym odpowiednikiem skryptu `test.bat`.
