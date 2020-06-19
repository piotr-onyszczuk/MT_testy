Narzędzie służy do testowania języka MiNI.

W plikach tests.txt, tests_groupA.txt, itp. znajdują się listy plików testowych
	
Pliki wymienione, np. w tests.txt powinny znajdować się w folderze tests\, oczekiwane wyniki powinny znajdować się w expected_results\ i mieć dokładnie takie same nazwy jak pliki w tests\, analogicznie w inputs\ powinien znajdować się oczekiwany plik wejściowy (jeśli jest potrzebny).
	
W przypadku oczekiwanego błędu kompilacji, plik z expected_results\ powinien zawierać "error", przykłady już istnieją.
	
Do testowania służą pliki *.bat. odpalamy plik test.bat (z VS CMD, z folderu gdzie znajduje się ten bat), pierwsym argumentem MUSI być ścieżka do exe z naszego projektu.
	
Pliki te generują wyniki do folderu results\. Komunikat "critical_error" w pliku informuje o błędzie na jednym z trzech etapów występujących po przejściu naszego kompilatora (kompilacja kodu CIL, peverify, wykonanie pliku exe). Komunikat "compiler_error" mówi o ujemnym kodzie wyjścia z naszego kompilatora, w szczególności najprawdopodobniej chodzi o unhandled exception. Przypominam że w przypadku błędu kompilacji zwracamy wartość dodatnią.

Outputy z results\ porównywane są z expected_results\. Wszystkie znalezione różnice są w pliku errors.txt. Jeśli zawiera on tylko linijkę "errors_detected" - oznacza to że wszystko jest OK.

Test "test_for5.bat", oprócz testów z "tests_for5.txt" agreguje wszystkie pozostałe grupy tesów.
	
W kompilatorze nie może być ReadKey ani ReadLine.
