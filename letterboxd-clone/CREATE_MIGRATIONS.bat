@echo off
echo Creating migrations directories and files...
echo.

cd /d "%~dp0letterboxd-clone\backend"

REM Create migrations directories
mkdir users\migrations 2>nul
mkdir movies\migrations 2>nul
mkdir reviews\migrations 2>nul

echo Created migrations directories
echo.

REM Create __init__.py files
echo # Empty __init__.py for migrations package > users\migrations\__init__.py
echo # Empty __init__.py for migrations package > movies\migrations\__init__.py
echo # Empty __init__.py for migrations package > reviews\migrations\__init__.py

echo Created __init__.py files
echo.

echo ============================================================
echo Now creating migration files...
echo ============================================================
echo.

REM Create users migration
(
echo # Generated migration file for users app
echo.
echo from django.db import migrations, models
echo import django.contrib.auth.models
echo import django.utils.timezone
echo.
echo.
echo class Migration^(migrations.Migration^):
echo.
echo     initial = True
echo.
echo     dependencies = [
echo         ^('auth', '0012_alter_user_first_name_max_length'^),
echo     ]
echo.
echo     operations = [
echo         migrations.CreateModel^(
echo             name='User',
echo             fields=[
echo                 ^('id', models.BigAutoField^(auto_created=True, primary_key=True, serialize=False, verbose_name='ID'^)^),
echo                 ^('password', models.CharField^(max_length=128, verbose_name='password'^)^),
echo                 ^('last_login', models.DateTimeField^(blank=True, null=True, verbose_name='last login'^)^),
echo                 ^('is_superuser', models.BooleanField^(default=False^)^),
echo                 ^('username', models.CharField^(max_length=150, unique=True^)^),
echo                 ^('first_name', models.CharField^(blank=True, max_length=150^)^),
echo                 ^('last_name', models.CharField^(blank=True, max_length=150^)^),
echo                 ^('email', models.EmailField^(blank=True, max_length=254^)^),
echo                 ^('is_staff', models.BooleanField^(default=False^)^),
echo                 ^('is_active', models.BooleanField^(default=True^)^),
echo                 ^('date_joined', models.DateTimeField^(default=django.utils.timezone.now^)^),
echo                 ^('bio', models.TextField^(blank=True, max_length=500^)^),
echo                 ^('profile_image', models.URLField^(blank=True^)^),
echo                 ^('groups', models.ManyToManyField^(blank=True, related_name='user_set', to='auth.group'^)^),
echo                 ^('user_permissions', models.ManyToManyField^(blank=True, related_name='user_set', to='auth.permission'^)^),
echo             ],
echo             options={
echo                 'verbose_name': 'user',
echo                 'verbose_name_plural': 'users',
echo             },
echo             managers=[
echo                 ^('objects', django.contrib.auth.models.UserManager^(^)^),
echo             ],
echo         ^),
echo     ]
) > users\migrations\0001_initial.py

echo Created users migration
echo.

REM Create movies migration  
(
echo # Generated migration file for movies app
echo.
echo from django.db import migrations, models
echo.
echo.
echo class Migration^(migrations.Migration^):
echo.
echo     initial = True
echo.
echo     dependencies = []
echo.
echo     operations = [
echo         migrations.CreateModel^(
echo             name='MovieCache',
echo             fields=[
echo                 ^('id', models.BigAutoField^(auto_created=True, primary_key=True^)^),
echo                 ^('movie_id', models.IntegerField^(unique=True^)^),
echo                 ^('title', models.CharField^(max_length=255^)^),
echo                 ^('poster_path', models.CharField^(blank=True, max_length=255, null=True^)^),
echo                 ^('overview', models.TextField^(blank=True^)^),
echo                 ^('release_date', models.CharField^(blank=True, max_length=50^)^),
echo                 ^('vote_average', models.FloatField^(default=0^)^),
echo                 ^('data', models.JSONField^(default=dict^)^),
echo                 ^('created_at', models.DateTimeField^(auto_now_add=True^)^),
echo                 ^('updated_at', models.DateTimeField^(auto_now=True^)^),
echo             ],
echo         ^),
echo     ]
) > movies\migrations\0001_initial.py

echo Created movies migration
echo.

REM Create reviews migration
(
echo # Generated migration file for reviews app
echo.
echo from django.conf import settings
echo from django.db import migrations, models
echo import django.db.models.deletion
echo.
echo.
echo class Migration^(migrations.Migration^):
echo.
echo     initial = True
echo.
echo     dependencies = [
echo         migrations.swappable_dependency^(settings.AUTH_USER_MODEL^),
echo     ]
echo.
echo     operations = [
echo         migrations.CreateModel^(
echo             name='Review',
echo             fields=[
echo                 ^('id', models.BigAutoField^(auto_created=True, primary_key=True^)^),
echo                 ^('movie_id', models.IntegerField^(^)^),
echo                 ^('rating', models.IntegerField^(^)^),
echo                 ^('review_text', models.TextField^(blank=True^)^),
echo                 ^('created_at', models.DateTimeField^(auto_now_add=True^)^),
echo                 ^('updated_at', models.DateTimeField^(auto_now=True^)^),
echo                 ^('user', models.ForeignKey^(on_delete=django.db.models.deletion.CASCADE, related_name='reviews', to=settings.AUTH_USER_MODEL^)^),
echo             ],
echo         ^),
echo         migrations.CreateModel^(
echo             name='Watched',
echo             fields=[
echo                 ^('id', models.BigAutoField^(auto_created=True, primary_key=True^)^),
echo                 ^('movie_id', models.IntegerField^(^)^),
echo                 ^('watched_date', models.DateField^(^)^),
echo                 ^('created_at', models.DateTimeField^(auto_now_add=True^)^),
echo                 ^('user', models.ForeignKey^(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL^)^),
echo             ],
echo         ^),
echo         migrations.CreateModel^(
echo             name='ReviewLike',
echo             fields=[
echo                 ^('id', models.BigAutoField^(auto_created=True, primary_key=True^)^),
echo                 ^('created_at', models.DateTimeField^(auto_now_add=True^)^),
echo                 ^('review', models.ForeignKey^(on_delete=django.db.models.deletion.CASCADE, to='reviews.review'^)^),
echo                 ^('user', models.ForeignKey^(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL^)^),
echo             ],
echo         ^),
echo     ]
) > reviews\migrations\0001_initial.py

echo Created reviews migration
echo.

echo ============================================================
echo   ✓ ALL MIGRATION FILES CREATED!
echo ============================================================
echo.
echo Created:
echo   - users\migrations\0001_initial.py
echo   - movies\migrations\0001_initial.py
echo   - reviews\migrations\0001_initial.py
echo.
echo Next step: Run python manage.py migrate
echo.
pause
