#include <sys/types.h>

/*
 * writeall() es un wrapper de write(2) que se asegura (mediante un
 * ciclo) que se escriban todos los bytes.
 *
 * Devuelve 0 si se escribieron todos los bytes; en caso contrario
 * (esto es, si write devolviÃ³ en algÃºn momento -1), se devuelve el
 * nÃºmero de bytes que sÃ­ pudo escribir.
 *
 * Precondiciones: fd >= 0, buf != NULL, count > 0.
 */
size_t writeall(int fd, const void *buf, size_t count);


/*
 * copyfd() lee todo el contenido de un file descriptor para escribirlo
 * en otro, usando como almacenamiento temporal el buffer proporcionado.
 *
 * La funciÃ³n lee como mÃ¡ximo "size" bytes de "fdin" en "buf",
 * y escribe los bytes leidos en "fdout", usando writeall().
 *
 * La funciÃ³n devuelve 0 si se copiÃ³ el archivo en su totalidad (esto es,
 * read llegÃ³ a devolver 0). En caso contrario, devuelve el nÃºmero de bytes
 * escritos (esto es, si read devolviÃ³ en algÃºn momento -1, o writeall
 * no pudo escribir todos los bytes).
 *
 * Precondiciones: fdin >= 0, fdout >= 0, buf != NULL, size > 0.
 */
size_t copyfd(int fdin, int fdout, void *buf, size_t size);