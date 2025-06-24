import React, { useState } from 'react';
import './FormularioCredito3R.css';
import logo from '../assets/logo.jpg';

const FormularioCredito3R = () => {
  const [form, setForm] = useState({});

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    const requiredFields = [
      'nombre', 'cedula', 'apodo', 'sexo', 'edad', 'ciudad',
      'estado_civil', 'vivienda', 'direccion', 'casa', 'sector',
      'telcasa', 'celular', 'empresa', 'cargo', 'dirtrabajo',
      'teltrabajo', 'tiempoempresa', 'ingresos', 'monto', 'tiempo_prestamo'
    ];

    const emptyFields = requiredFields.filter(field => !form[field] || form[field].trim() === '');

    const referenciasValidas =
      (form.ref1 && form.ref1.trim() && form.tel1 && form.tel1.trim()) ||
      (form.ref2 && form.ref2.trim() && form.tel2 && form.tel2.trim()) ||
      (form.ref3 && form.ref3.trim() && form.tel3 && form.tel3.trim());

    if (emptyFields.length > 0 || !referenciasValidas) {
      alert('Por favor completa todos los campos obligatorios. Al menos una referencia debe estar llena.');
      return;
    }

    try {
      const response = await fetch('http://localhost/enviar-formulario.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(form),
      });

      const result = await response.json();
      if (result.status === 'ok') {
        alert('✅ Solicitud enviada. ¡Gracias por confiar en Inversiones 3R!');
      } else {
        alert('❌ No se pudo enviar la solicitud. Intenta nuevamente.');
      }
    } catch (error) {
      alert('⚠️ Error de conexión con el servidor.');
    }
  };

  return (
    <div className="form-container">
      <img src={logo} alt="Logo Inversiones 3R" className="logo" />
      <h2>Formulario de Solicitud de Crédito</h2>
      <form onSubmit={handleSubmit}>
        <div className="section-title">Datos Personales</div>
        <div className="form-grid">
          <div><label>Nombre completo</label><input name="nombre" onChange={handleChange} /></div>
          <div><label>Cédula</label><input name="cedula" onChange={handleChange} /></div>
          <div><label>Apodo</label><input name="apodo" onChange={handleChange} /></div>
          <div><label>Sexo</label>
            <select name="sexo" onChange={handleChange}>
              <option value="">Seleccione</option>
              <option value="masculino">Masculino</option>
              <option value="femenino">Femenino</option>
              <option value="otro">Otro</option>
            </select>
          </div>
          <div><label>Edad</label>
            <select name="edad" onChange={handleChange}>
              <option value="">Seleccione</option>
              <option value="18-25">18-25</option>
              <option value="26-35">26-35</option>
              <option value="36-45">36-45</option>
              <option value="46-60">46-60</option>
              <option value="60+">60+</option>
            </select>
          </div>
          <div><label>Ciudad</label>
            <select name="ciudad" onChange={handleChange}>
              <option value="">Seleccione</option>
              <option value="Azua">Azua</option>
              <option value="Bahoruco">Bahoruco</option>
              <option value="Barahona">Barahona</option>
              <option value="Dajabón">Dajabón</option>
              <option value="Distrito Nacional">Distrito Nacional</option>
              <option value="Duarte">Duarte</option>
              <option value="Elías Piña">Elías Piña</option>
              <option value="El Seibo">El Seibo</option>
              <option value="Espaillat">Espaillat</option>
              <option value="Hato Mayor">Hato Mayor</option>
              <option value="Hermanas Mirabal">Hermanas Mirabal</option>
              <option value="Independencia">Independencia</option>
              <option value="La Altagracia">La Altagracia</option>
              <option value="La Romana">La Romana</option>
              <option value="La Vega">La Vega</option>
              <option value="María Trinidad Sánchez">María Trinidad Sánchez</option>
              <option value="Monseñor Nouel">Monseñor Nouel</option>
              <option value="Monte Cristi">Monte Cristi</option>
              <option value="Monte Plata">Monte Plata</option>
              <option value="Pedernales">Pedernales</option>
              <option value="Peravia">Peravia</option>
              <option value="Puerto Plata">Puerto Plata</option>
              <option value="Samaná">Samaná</option>
              <option value="San Cristóbal">San Cristóbal</option>
              <option value="San José de Ocoa">San José de Ocoa</option>
              <option value="San Juan">San Juan</option>
              <option value="San Pedro de Macorís">San Pedro de Macorís</option>
              <option value="Sánchez Ramírez">Sánchez Ramírez</option>
              <option value="Santiago">Santiago</option>
              <option value="Santiago Rodríguez">Santiago Rodríguez</option>
              <option value="Santo Domingo">Santo Domingo</option>
              <option value="Valverde">Valverde</option>
            </select>
          </div>
          <div><label>Estado civil</label>
            <select name="estado_civil" onChange={handleChange}>
              <option value="">Seleccione</option>
              <option value="soltero">Soltero/a</option>
              <option value="casado">Casado/a</option>
              <option value="union libre">Unión libre</option>
              <option value="divorciado">Divorciado/a</option>
              <option value="viudo">Viudo/a</option>
            </select>
          </div>
          <div><label>Tipo de vivienda</label>
            <select name="vivienda" onChange={handleChange}>
              <option value="">Seleccione</option>
              <option value="propia">Propia</option>
              <option value="alquilada">Alquilada</option>
              <option value="familiar">Familiar</option>
              <option value="otro">Otro</option>
            </select>
          </div>
          <div><label>Dirección</label><input name="direccion" onChange={handleChange} /></div>
          <div><label>Casa No.</label><input name="casa" onChange={handleChange} /></div>
          <div><label>Sector</label><input name="sector" onChange={handleChange} /></div>
          <div><label>Tel. Casa</label><input name="telcasa" onChange={handleChange} /></div>
          <div><label>Celular</label><input name="celular" onChange={handleChange} /></div>
        </div>

        <div className="section-title">Información Laboral</div>
        <div className="form-grid">
          <div><label>Empresa</label><input name="empresa" onChange={handleChange} /></div>
          <div><label>Cargo</label><input name="cargo" onChange={handleChange} /></div>
          <div><label>Dirección de trabajo</label><input name="dirtrabajo" onChange={handleChange} /></div>
          <div><label>Teléfono trabajo</label><input name="teltrabajo" onChange={handleChange} /></div>
          <div><label>Tiempo en la empresa</label><input name="tiempoempresa" onChange={handleChange} /></div>
          <div><label>Ingresos mensuales</label>
            <input type="number" name="ingresos" min="10000" step="500" onChange={handleChange} />
          </div>
        </div>

        <div className="section-title">Referencias Personales</div>
        <div className="form-grid">
          <div>
            <label>Nombre 1</label><input name="ref1" onChange={handleChange} />
            <label>Teléfono 1</label><input name="tel1" onChange={handleChange} />
          </div>
          <div>
            <label>Nombre 2</label><input name="ref2" onChange={handleChange} />
            <label>Teléfono 2</label><input name="tel2" onChange={handleChange} />
          </div>
          <div>
            <label>Nombre 3</label><input name="ref3" onChange={handleChange} />
            <label>Teléfono 3</label><input name="tel3" onChange={handleChange} />
          </div>
        </div>

        <div className="section-title">Datos del Préstamo</div>
        <div className="form-grid">
          <div><label>Monto solicitado</label>
            <input type="number" name="monto" min="10000" step="500" onChange={handleChange} />
          </div>
          <div><label>Tiempo (meses)</label><input type="number" name="tiempo_prestamo" onChange={handleChange} /></div>
          <div style={{ gridColumn: 'span 2' }}>
            <label>Observaciones</label>
            <textarea name="observaciones" onChange={handleChange}></textarea>
          </div>
        </div>

        <button type="submit">Enviar Solicitud</button>
      </form>
    </div>
  );
};

export default FormularioCredito3R;
