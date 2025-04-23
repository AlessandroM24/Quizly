<?php

namespace App\Models;

use CodeIgniter\Model;

class UtenteModel extends Model
{
    protected $table = 'utenti';
    protected $primaryKey = 'id_utente';
    protected $allowedFields = ['username', 'password', 'ruolo', 'id_docente', 'id_studente'];
}
