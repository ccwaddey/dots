/*
 * Copyright (c) 2021 Chris Waddey <admin@hoolizen.com>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#include <errno.h>
#include <signal.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <syslog.h>
#include <unistd.h>

#define XIDLEPATH "/usr/X11R6/bin/xidle"
#define PIDFILE "/tmp/.myxidle.pid"
#define ERRORFILE "/var/log/mylog.log"
#define LI	LOG_INFO
#define LE	LOG_ERR

int
main(int argc, char *argv[]) {
	FILE	*fp;
	pid_t	 mypid = 0;
	int	 rv;

	openlog("myxidle", LOG_PID, LOG_AUTH);
	syslog(LI, "entering myxidle");
	if (argc > 1) {
		syslog(LI, "in close branch");
		/* Kill the xidle pid we created */
		if ((fp = fopen(PIDFILE, "r")) == NULL) {
			syslog(LE, "myxidle (close) could not open "
			    PIDFILE "\n");
			return 0;
		}
		if (!fscanf(fp, "%d", &mypid)) {
			syslog(LE, "myxidle (close) could not read "
			    PIDFILE "\n");
			return 0;
		}
		syslog(LI, "killing xidle pid: %d\n", mypid);
		if (kill(mypid, SIGKILL)) {
			if (errno == ESRCH)
				syslog(LE, "myxidle (close) read bad pid\n");
			else
				syslog(LE, "myxidle (close) unknown error\n");
		}
		fflush(fp);
		ftruncate(fileno(fp), 0);
		return 0;
	}

	if (daemon(0, 0)) {
		syslog(LE, "myxidle could not daemonize\n");
		return 0;
	}
	
	syslog(LI, "in xidle branch");
	mypid = getpid();
	if ((fp = fopen(PIDFILE, "w")) == NULL) {
		syslog(LE, "myxidle could not open " PIDFILE "\n");
		return 0;
	}
	syslog(LI, "writing pid %d", mypid);
	if (fprintf(fp, "%d", mypid) < 0) {
		syslog(LE, "myxidle could not write pid %d\n", mypid);
		return 0;
	}
	fflush(fp);

	syslog(LI, "exec'ing xidle");
	closelog();
	rv = execl(XIDLEPATH, "xidle", "-display", ":0", "-no", "-timeout",
	    "240", "-program", "/usr/sbin/apm -S", NULL);
	/* Shouldn't get to this */
	syslog(LE | LOG_AUTH, "myxidle failed to exec\n");
	return rv;
}
