import socket as soc
def func_1():
    host = soc.gethostname ( )
    port = 6969

    client_socket = soc.socket()
    client_socket.connect((host, port))

    message=input(" -> ")

    while message. lower().strip() != 'end':
        client_socket.send(message.encode())
        data = client_socket.recv(1024).decode()

        print('Received from server: ' + data)

        message=input(" -> ")

    client_socket.close()
if __name__ == '__main__':
    func_1()


