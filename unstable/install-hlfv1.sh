(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else   
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� �`Y �]Ys�:�g�
j^��xߺ��F���6�`��R�ٌ���c Ig�tB:��[�/�$!�:���Q����u|���`�_>H�&�W�&���;|Aq������I}���Ӝ��dk;�վ�S{;�^.�Z�?�#�'��v��^N�z/��˟�)��xM��)����!AV�/o����;����GI
��_.����^q��:.�?�V������>[ǩ��@�\��b����5|��/��t9��{Lĝ��^u�=��K��I�y�;��q��Y��������O#��9��`���M����4��됄�{.�P������4E2�k;E�(����}�ث�s�!������?N���?��@)��p�u'6d�&�B�z�lC��E�)M��(�2�I}a,0���F)�[e�ւ6U�	�e���i�ϯ}�`!���x�	Z��Աc���#��sݧ(��h��:���OYz8�l%�n���Ri&������Ł��"�-T?�%�^|��}��+��K��ww�o�_���M����������j��|���2��o�?zp�W�?J����X��K��ϋ�!K2_��[�/�|��y�vC��eMYJ|2�{[f���-�e�6���|��i� f\�hY�%����98��R���甶�I�=o݈L,C*�v��v�:���,���5$g�H�9QW s��D�݆�p��~|w�z\��P��-ƣVύܝ�#H0D\�\9^���H0�"Mޫ����Ď��L�4��x :t�94��:q���[{(���\C0��)�p#ica���1���8?n�.�B~�A�'�xh���Tn�pJ�۟i��B�ӛ�B"N�U1"�6o��b�IdJ؍�i�v�k���2uN�em
h�	���\2T�p;ByWZj�����՝)�̵����y
 ���	����&E��@���~��hp�~|n���L�>�\G�/��:]dL�A����~�bd�T��M�6�7#Q�o�+��P��Hq���@^�N�2�'1�E]��YF�y���g|���v.��r���6��(^������Y�r,�Y��i6�uه�fó��w��r�K�?��o����?JT�_
>H��ҟ� ��?���1�(^�	x���Y��Nt��:PC��f{��W�d�%��'�s>��v<�3�H'B�~Ĩ�*�#F};��rd��A��`� �EZ��`����4E�w���7��0EWrH<�0��'�5�%��;�b��V.�S^S�Q���lM�HM\L���C�f�ߛe�.�i���ռ���ž�@h]�.?���gN�ȅ�D�=�5af[8�ȑ�[���9k@@H\^d��!��
 y;?U2�x-�cb��a�59p�k9�;�u]�����f�ڔ�Q"��0~:h=��E�Fѥ>��6s0!����8N�H�YD��M��_��~a(�v�7�6cyb|�M����u-�WS�ͬ��C��db<�?�/��~����I���?J����g�������������������s�_��o�	���	� *�/�$�ό���RP��T�?�>�I���D1�(�-�N�S$[�:ASv@ ,и�`.�P�.J(F�GzU��߅2������������+����8؏;���p����.��g	}��@���p�����ֲ�۶̈ɸ!'MS�L���-eXO6C����c�}��t�Y�̱�1G[K|���n�,�F	�6Kٞ�U��{�K��3����R�Q�������������j��Z�{��������K���Q����T�_)x[�����{3��#�C��)���h��t��>����c����f�M���� ���&s�;P�\��#�.�CL2����ܚ�=���a�|�P��I��N���lXo&�w�A�1hJ�x\LХ7(w�j��1<tO��1G�������t���stNnq���,�2�s����g�@[���`%N��;���g�m��I��(/�A���{�?-L{�dЄ�NSD�>�1�?��h�������Np���Y�3�ei��@y��1�TpD	i'b$�#�����HȜ'pr�CZ�?�����g�� �����g��T�_
*����+��ϵެ�]��G�]��hA���K��
Ϳ���#P���RP��������;����c[ A����+���ؤ�N?�0P>���v�����n��[�7�"��"B�,J�$I�U���2�y�BSde�����T&��j�R��͉�1]0��cϑV�f?h�CO^��(���0�;uZI��!��h;��e>^�0�m�F9fl������#Bݞ��� ��|�q��g��Rrj��U��������~����(MT���������S�߱�CU������2�p����������x��e�p��i��+������K�A/�?�bh�����?�>��IW�?e�S�?K#t�������6�26�R��Q��,��x4B��x���o���BQi(C��������2p��O���>H-�j7���X&��\=V�k��������Հ&\xٮ��sX]W|.E�T�;��ͣ�L8�u>ʼf$���-�?����!�V�g"�	���� ����֫��w�#��K�A�a��H�������CI��G!xe���O���/��P&ʐ�+�J�O�	��������>�y���;b%�A�*�5��`�����������п?�c�ㆹ�T��bxT�޺��p#s���s�֣s������{4��i�M;�L(�|�#�S:E_̋G�m;��~�ILW���	�<�-b�Zt3����������P�YOԉ5�����j�s�ފ���{�A3Q�t�r֓��ex�L>2�{Ġ��Ām���N��-���x�����E�ք~ހNQe�6�xN�/ݩ�۝�ؐ�����^��.uF$��m�,O7|���0�v�X���M�i����o�)��足��Y�9ˌ������mo9�� ����N�ʹ��\��ފ��>�[Z��>\d��BiH�?/�#��K���a��de�������������9�����[���j�?��I�tu�{)x�������q`�~��[����NS!�����������䙡��7P���F���>���my�@M�wM��-���� �B$�vr��))�ci�J�hl�F�˶���[��SS�m�ߚ���&4�T6c��ij]�r�
��H��'}5i�v��@���q6��K����>@ k��#'P#�ڬ��]z�M��J̳F��K]��O�\;|�՞ق%w��Z�o�~�;�F�&����-T�}z�x�ϳ���#��K�A\n�ū��R�[�����j�OI���_-��sP��ߵ�OU�������j��Z����)0���U��\.��������Q(R�����+��������b������T��V
.��#l��0�D)ơH�p�g0�D|g4�iGp%2`}*�}�\sëS`~+�!�W���r�������`�PZ�d��a�2�f�����9��6ض��"o䑶hQ����hN�m�`]	otw�K��#`����;VaDI�1�ַ����0�k�d=�(G��b(���:�b��W��/v�~Z��(�3�z->�?��(��O�!P����R��Ӭ��_kaAP�۩�g_�Z͵��V�Fv��M���.|/,�c`;�Խr��;����+��F��E2�O���i/#�>WR�]�$��2Ã�fW���څX�ձ~z�`���{�*	����_��b�F���Z�&�+����:jG�kWE��q�"�.�ګw~r����sEsY=pr^�ʩ�6X|=�M�jWީ��b�����T��o}���^����Oo�vT�
׾��*
��
�#�i��W��m���VWD]�o�*�sӑ���A��~�r}�y���ڗ��h4�·�l_+*ɝ��sG�w�:��4̮o��Yz���vy�Q�=Y��=�x�jiA֟� ʒ;���
�N����#�j/���X�I"}~����<<��>ΐ������yew�����ݮ�������*�~�����=�����E�����wjj���2����'k8�{=��ԅ��z�q������Hj�Z�a�MX�@��)��x>���b�?��|8"�۞�������n8��H1�]]��@V�� ވ#��!+bw`|c��㲪82��Ӎ�8�T�9#���j|�,���0O�lo�N7K�lI]g'��=���]m��V�n/���s�����@oCPoѝ�u��)P�8q�q���N���q�$N��]!�R���P�� -hT�� �����Z	-�
�e�h%�p�$�d��d���R|�tǱ�����}����9�-4���[��Mgs���&�+��PB��!�P���):ː��jx0ہ��K�r�̭t6�����ֵc��'	5[_��h6E&��;6�z`Z��Xtk5 �z��tL�%�Y�mA�	%b´�w���誫�� 8��۵�����dh�Z�p�+��. ����&̸x���Ȗ��]̀�	��xl��&�L|t�V�.�w$M1�>��\~�C��t�a��wZ�~�&����}�x��s�M�:f��5���iUV�i�2b�*��|6�V����r�<�J��Ҕ�ꨉ�ة���nߜ�EM�[���MWa��M��<�bg�ӵ�8u��lpX�S�oN��Ng'&~���zD��uvu�ή��~$�j�S[�ۏ���ߣ�9��i�]x�I-�����n*�f�&,NT�q�v�?m�\nx�Q0{:��拰�~|A���D疮�kf���2�xT�&����*L��a��h+�����|](8-��-_�0U䕜���)��-�� }L�7��Mk��U��uT��|ú��Yjt�jK\Z������t��Ѿ^����ْ�	n�0��~�^��G�=��h��IZ��G�KR�:Sf:.K���a�̘�{[���7��=���ɹ{?|CX���(��j�Ɇ��UE��]��څ�o����]]����5XUb����
�͛F��+�G��|�M66<��Zu��ǋ���,~�������?�~�H��Ai��Υ����S߻�}��7����ޠ�穇0�B|����x��^b�ϋx�������
D���� &�\�}"�M�����K]���{>�`=�o��q��O�˭g����/�<+���|������<�a\y��o\o2���|��k׿r�RcX07��N7�������n�q���&�<r���l31`�Aʜ�k���5��<?D�#,����6~c�\6,${���
Tz7���D��{����9��������sB�˵KsPU��
�b�>�f����q'r�b3<���fn	���$>���m�6tW�4U�[��F��*l���Y6φ';�%\���Lx�,8f��vY����P˵v3e�C��J��h�FJ�*EY��q5S�H	)�y4�6P)e�Ut]ex�C~?�g44��7+���j�8r��K�a�:L�M��ȗOD�����̱���"���'8%���Ԍ�� �{jn��{���R߈gZ>�%À��IO2ʥ��.گ
ͤ��$�j�8�E���Nk ��SpZ�E�|�-�`u:d��q��b�j�:h�"�X�':>1�.!���)��%d%{�]����^��`�N=��Q�~�Q�&ct0��y�a��F�Z�ӲB����q_�g۩p��O%K�ZR�9��6#� �Ŏ�F��W��9)˚X�eϛ�-�G�DW+����3*���TK@�\q,a�����AN�ģ�p���XgX��D9ӑ�L��dd_�bL���꠽ϜNYHNa�FYabl����e� W$s%��,G�d�*K\���@y�gc�2�b��x5T0��bq5�&۬Lb�����r���ax�L:�b�6W-J��7�H�C��Q���*Kb��W(��xein�,q<19#�jB�io�R��G�{�Rol��%��(v��� Bz���eu��M�k�:�l	�7�%��j�{:e��醒�H?���*H�c\Ɠ�U[R�#��k�����q�{���RE�Pv0ʳ�r�ѢxJ*��)/[���-N�m)�A�J��.t)�𕚾�˧e��F)�/]����l����l��l;�H3�g�qpwIotE�@ޅ\ۺ�A��K�;v� o���3�����������l#W��l�9_UV�k��j���a�+�f�]�u�����]^��m�"��+�.Z��2��F����>RD�K*������jSȊFWoX_5dk��{)xF�=#?�Dd�.���"np�՚\c,"oA.o��g��6v��g\�m��ι�\�zf��/�27�}a�X�F�j9�V�^(|��8�ʳ�͖�����=�u� ߾.���bR��ב�#f`Ŋ�#?Ev0(�dU7?���
 �ˊ�o?�c۟���'��?o#��F�w��<��y)�������i{�A�CSZ3W��0*v��=�^~i�A���Ց�Y[�E��ɠa-:+�p����V�,88s4�Y��
X��|��":�'����H��h��2�3�JkX�����iD�WB}�Ec�=#�
��N�G�F��-��TX�1J�;\���s�n�iC���q�ƒ>K�#{0q �5��,&{>B��R�<&�Ocf<4KZC�����&R� �0�Qq�?�������I�	�kh���qȊ���1�H�%�����pY%�����o6�����G���!3HHᎬ���1j�n�04@(��_���ǥ�Qd"z�q��p��1��Xϡ���6�T�uι�l�CS�d>��g�0f{v�"A��2܋\�3��3�{�������c|�O�ayo���D��8��M��\p�oU��4Vm�����M�Ϗ�%2Q�|�#���*�֢r���Ar!(2����Ef����|��,k8?&V.��!���R����r�+�p,�!1��1��	a\�@��h8#�UCH Y��4ڊ���#U�?��F�@�V2
�$�h�49���B�R���|�/R��W�b7�;��0���J�.���_���0tP��]oL
0�aݯdjdZTå�8�A�\
c��x�� �����p��7�ԞB��wyZ4��J!���Ӥ�Ѭ�ұK;o�a9���ߛq����.F�6rʼ�v�rl��($�A�m�&x�
�E�.��ёr]�'t{�-��L�͉oO#�d����!����.�ym��`{Z(�H*��� �����^����#KqT�I�y\D. w�n�M`3�~��������C��؟��/=���؋�}���A�1�᭮:<|��nNZL+'��s'�?q���?��y[p︾�����Sl���]��>�����O~��y���~�����ȿ'�����In�i���-���hL�5j�r�w����w?���(o�g��#���~�>���/1ȯ��s�Ο������t���ӡv:4�&�P;�������N@�	H;�N���P;����^��S�-o#��)H���@��*e���)�-��VBgρzn��s&�����#���_G^��&��8<ǭsxΧT�S��3p��1�׌gp��X���`;_/�M�Y�i9sf�h�3gƙ�Lp��8���m�3s���g�s;f��8�0�)Bk��6_]��9�9ϋ_jw��c��INr�����Mx;,�  