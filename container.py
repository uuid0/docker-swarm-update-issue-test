import signal
from time import sleep


class Runner:
    _should_run: bool

    def run(self):
        self._should_run = True
        signal.signal(signal.SIGTERM, self._on_sigterm)

        print('Started')
        while self._should_run:
            print('.')
            sleep(300.0)
        print('Finished')

    def _on_sigterm(self, sig=None, _frame=None):
        print(f'Received {sig}')
        self._should_run = False


if __name__ == '__main__':
    runner = Runner()
    runner.run()

