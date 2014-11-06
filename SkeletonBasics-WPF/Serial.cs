using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO.Ports; // Importante para el manejo del puerto serial

namespace Microsoft.Samples.Kinect.SkeletonBasics
{
    public class Serial
    {
        static SerialPort _serialPort;
        /**
         * Funcion que envia datos a traves del puerto serial de la computadora
         */
        public static void enviarDatos(int pNumber)
        {
            // Crea un nuevo objeto puerto serial
            _serialPort = new SerialPort("COM4", 9600, Parity.None, 8, StopBits.One);//SerialPort.GetPortNames()[0].ToString(), 9600, Parity.None, 8, StopBits.One
            _serialPort.Handshake = Handshake.None;

            _serialPort.Open();

            byte[] buffer = new byte[] { Convert.ToByte(pNumber) };
            _serialPort.Write(buffer, 0, 1);
            _serialPort.Close();
        }
    }
}
