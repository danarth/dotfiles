local M = {}

function M.setup()
  local jdtls = require('jdtls')
  local jdtls_setup = require('jdtls.setup')

  local on_attach = function ()
    jdtls_setup.add_commands()
  end

  jdtls.start_or_attach({
    on_attach = on_attach,
    cmd = {'jdtls'},
    root_dir = jdtls_setup.find_root({'gradlew', '.git', 'mvnw'}),
    settings = {
      java = {
        configuration = {
          runtimes = {
            {
              name = "JavaSE-1.8",
              path = "/usr/lib/jvm/java-1.8.0-amazon-corretto",
            },
            {
              name = "JavaSE-11",
              path = "/usr/lib/jvm/java-17-openjdk-amd64",
            }
          },
        }
      }
    }
  })
end

return M
