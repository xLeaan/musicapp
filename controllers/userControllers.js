const db = require('../conexion/conexion');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const registerUser = async(req, res) => {
  const { email, nombre, apellido, contrasena, rol } = req.body;

  if (!email || !nombre || !apellido || !contrasena) {
    return res.status(400).json({ message: "Faltan campos" });
  }

  try {
    // contraseña encriptada
    const hashedPassword = await bcrypt.hash(contrasena, 10); 
    
    const sql = 'INSERT INTO users (email, nombre, apellido, contrasena, rol) VALUES (?, ?, ?, ?, ?)';
    db.query(sql, [email, nombre, apellido, hashedPassword, rol], (err, result) => {
    
    if (err) {
      console.error('Error al registrar usuario:', err);
      return res.status(500).json({ message: 'Error al registrar usuario' });
    }
    res.status(201).json({ message: 'Usuario registrado correctamente' });
  });
  } catch (error) {
    console.error("Error al hashear la contraseña:", error);
    res.status(500).json({ message: 'Error interno del servidor' });
  } 
};

const loginUser = (req, res) => {
    const { email, contrasena } = req.body;
  
    const sql = 'SELECT * FROM users WHERE email = ?';
    db.query(sql, [email], async (err, results) => {
      if (err) return res.status(500).json({ message: 'Error en el servidor' });
      if (results.length === 0) return res.status(404).json({ message: 'Usuario no encontrado' });
  
      const user = results[0];
      const match = await bcrypt.compare(contrasena, user.contrasena);
      if (!match) return res.status(401).json({ message: 'Contraseña incorrecta', user });

      const token = jwt.sign(
        {
            id: user.id,
            email: user.email,
            nombre: user.nombre,
            rol: user.rol
        },
        process.env.TOKEN_USER,
        { expiresIn: '8h' }
      );
  
      res.status(200).json({ 
        message: 'Login exitoso', 
        token,
        user: {
            id: user.id,
            email: user.email,
            nombre: user.nombre,
            rol: user.rol
        }
     });
    });
};

module.exports = {
  registerUser,
  loginUser
};
