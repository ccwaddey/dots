#include <err.h>
#include <pwd.h>
#include <readpassphrase.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int
main(int argc, char *argv[]) {

	char *hash, *pw, pwb[_PASSWORD_LEN];
	int rv;

	if ((hash = malloc(_PASSWORD_LEN)) == NULL)
		exit(1);

	/* if (argc < 2) */
	/* 	exit(2); */

	pw = readpassphrase("password: ", pwb, _PASSWORD_LEN, 0);
	if (pw == NULL) {
		exit(2);
	}
	rv = crypt_newhash(pw, "bcrypt,a", hash, _PASSWORD_LEN);

	if (rv == -1)
		err(1, "crypt_newhash");

	rv = crypt_checkpass(pw, hash);
	if (rv == -1)
		err(1, "crypt_checkhash");
	/* printf("check good (rv == %d)\n", rv); */
	printf("%s\n", hash);

	exit(0);
}
